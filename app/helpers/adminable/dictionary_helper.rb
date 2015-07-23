module Adminable
  module DictionaryHelper

    def dictionary_fields(f, fields = Adminable::Dictionary.fields)
      get_fields_array(f, fields).join('').html_safe
    end

    # count: Количество столбцов, на которые надо разделить поля
    def splitted_dictionary_fields(f, count, fields = Adminable::Dictionary.fields, &block)
      fields_array = get_fields_array(f, fields)
      fields_array.each_slice((fields_array.size*1.0/count).ceil).each_with_index do |sub_fields, index|
        block.call(sub_fields.join('').html_safe, index)
      end
    end

    def get_field(object, method)
      result = object.send(method)
      return '' unless result.present?
      if result.is_a? ActiveRecord::Base
        result.send(:name)
      elsif result == !!result
        result ? 'Да' : 'Нет'
      else
        result
      end
    end

    private

      def get_fields_array(f, fields)
        fields.sort_by{|el| (el.respond_to?(:priority) ? el.try(:priority) : el).to_i}.map do |field|
          if field.available.blank? || @dictionary && @dictionary.parent && (field.available & (@dictionary.ancestors.pluck(:tag) + [f.object.tag]).find_all{|x| !x.blank?}).any?
            validation_class = " "
            validation_class << 'validate[required] ' if field.required
            collection = field.get_collection
            if field.select_tag.present?
              f.input "#{field.value}_id", as: :select, collection: collection, label: field.name, input_html: {class: validation_class}
            elsif field.select_tag_array.present?
              f.input "#{field.value}_ids", as: :select, collection: collection, label: field.name, input_html: {multiple: 'multiple', class: 'select2' + validation_class}
            else
              value = f.object.send(field.value)
              case field.variable_type.try(:value)
              when 'boolean'
                f.input field.value, as: :boolean, label: field.name, wrapper: :check_box, input_html: {class: 'ace' + validation_class}
              when 'datetime'
                f.input field.value, label: field.name, input_html: {class: 'date-timepicker' + validation_class}
              when 'float', 'integer'
                f.input field.value, label: field.name, input_html: {class: validation_class, value: value == 0 ? '' : value, placeholder: value}
              else
                f.input field.value, label: field.name, input_html: {class: validation_class}
              end
            end
          end
        end.compact
      end

  end
end
