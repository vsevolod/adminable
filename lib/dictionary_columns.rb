# Удалить: Adminable::Dictionary.update_all('data = delete("data", \'available\')') http://blog.yannick.io/rails/2013/08/02/rails-4-active-record-hstore.html
module DictionaryColumns

  def self.included(base)
    base.send :class_attribute, :fields
    base.send :class_attribute, :hstore_column
    base.extend DictionaryColumns::ClassMethods
  end

  module ClassMethods

    def human_name
      I18n.t(self.name.parameterize('.'), count: 1)
    end

    def horder(column, type = 'text')
      order("(CASE #{self.hstore_column} -> '#{column}' WHEN '' THEN NULL ELSE #{self.hstore_column} -> '#{column}' END)::#{type}")
    end

    def add_columns(tag = nil, &block)
      return unless ActiveRecord::Base.connection.table_exists? 'adminable_dictionaries'
      tag ||= self.model_name.collection.sub('/','_')
      fields_field = Adminable::Dictionary.find_by_tag(tag.to_s)
      fields = if fields_field
                 if block
                   block.call(fields_field)
                 else
                   fields_field.subtree.where("value IS NOT NULL AND value != ''").by_priority
                 end
              else
                []
              end
      self.fields = fields
    end

    def add_store_accessor(hstore_column = :data)
      return unless ActiveRecord::Base.connection.table_exists? 'adminable_dictionaries'
      self.hstore_column = hstore_column
      self.store_accessor self.hstore_column, self.fields.map(&:value)

      # Переопределяем методы
      self.fields.each do |field|
        # Если значение массив
        if !field.select_tag_array.blank?
          self.redefine_method field.value.to_sym do
            value = read_store_attribute(self.class.hstore_column, field.value)
            array = if value.present?
                      JSON.parse(value.sub('"", ', ''))
                    else
                      []
                    end
            if field.reference_id.present?
              if field.variable_type.try(:value) == 'collection'
                field.reference_id.capitalize.constantize
              else
                Adminable::Dictionary
              end.where(id: array)
            else
              array
            end
          end
          if field.reference_id.present?
            self.redefine_method "#{field.value}_ids".to_sym do
              value = read_store_attribute(self.class.hstore_column, field.value)
              if value.present?
                JSON.parse(value.sub('"", ', ''))
              else
                []
              end
            end
            self.redefine_method "#{field.value}_ids=".to_sym do |new_values|
              self.send("#{field.value}=", new_values)
            end
          end
        elsif field.reference_id.present?
          self.redefine_method field.value.to_sym do
            collection_model = if field.value != 'variable_type' && field.variable_type.try(:value) == 'collection'
                                 field.reference_id.titleize.constantize
                               else
                                 Adminable::Dictionary
                               end
            collection_model.find_by_id(read_store_attribute(self.class.hstore_column, field.value).to_s)
          end
          self.redefine_method "#{field.value}_id".to_sym do
            read_store_attribute(self.class.hstore_column, field.value).to_i
          end
          self.redefine_method "#{field.value}_id=".to_sym do |new_value|
            self.send("#{field.value}=", new_value)
          end
        # Если значение содержит поле тип
        elsif field.variable_type.present?
          # Следующая строка магическая. Без неё всё сломается
          variable_type = field.variable_type.is_a?(String) ? Adminable::Dictionary.find(field.variable_type) : field.variable_type
          case variable_type.value
          when 'float'
            self.redefine_method field.value.to_sym do
              read_store_attribute(self.class.hstore_column, field.value).to_f
            end
            self.redefine_method "#{field.value}=" do |new_value|
              write_store_attribute(self.class.hstore_column, field.value, new_value.to_s.sub(',', '.').to_f)
            end
          when 'integer'
            self.redefine_method field.value.to_sym do
              read_store_attribute(self.class.hstore_column, field.value).to_i
            end
            self.redefine_method "#{field.value}=" do |new_value|
              write_store_attribute(self.class.hstore_column, field.value, new_value.to_s.to_i)
            end
          when 'boolean'
            self.redefine_method field.value.to_sym do
              read_store_attribute(self.class.hstore_column, field.value) == 'true'
            end
            self.redefine_method "#{field.value}=" do |new_value|
              write_store_attribute(self.class.hstore_column, field.value, new_value != '0' && new_value != false)
            end
          end
        end
      end
    end

    def permit_values
      permit_array = []
      self.fields.each do |f|
        if f.select_tag_array.present?
          permit_array.push({(f.value.to_sym) => [], "#{f.value}_ids".to_sym => []})
        elsif f.select_tag.present?
          permit_array += [f.value.to_sym, "#{f.value}_ids".to_sym, "#{f.value}_id".to_sym]
        else
          permit_array.push f.value.to_sym
        end
      end
      permit_array
    end

  end

end
