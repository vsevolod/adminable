module ActiveAdmin::DictionaryHelper

  def dictionary_fields(f, fields = Dictionary.fields)
    get_fields_array(f, fields).join('').html_safe
  end

  # count: Количество столбцов, на которые надо разделить поля
  def splitted_dictionary_fields(f, count, fields = Dictionary.fields, &block)
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
      fields.sort_by{|el| (el.respond_to?(:position) ? el.try(:position) : el).to_i}.map do |field|
        #if field.available.blank? || @dictionary && @dictionary.parent && (field.available & (@dictionary.ancestors.pluck(:tag) + [f.object.tag]).find_all{|x| !x.blank?}).any?
        if field.available? || @dictionary && @dictionary.parent && (@dictionary.ancestors.pluck(:tag) + [f.object.tag]).find_all{|x| !x.blank?}.any?
          validation_class = " "
          #validation_class << 'validate[required] ' if field.required
          if field.methods.include?(:select_tag) && field.select_tag.present?
            f.input "#{field.value}_id", as: :select, collection: field.get_collection, label: field.name, input_html: {class: validation_class}
          elsif field.methods.include?(:select_tag_array) && field.select_tag_array.present?
            f.input "#{field.value}_ids", as: :select, collection: field.get_collection, label: field.name, input_html: {multiple: 'multiple', class: 'select2' + validation_class}
          else
            #value = f.object.send(field.value)
            case field.variable_type.try(:value)
            when 'boolean'
              f.input field.value, as: :boolean, label: field.name
            when 'datetime'
              f.input field.value, label: field.name
            when 'float', 'integer'
              f.input field.value, label: field.name
            else
              f.input field.value, label: field.name
            end
          end
        end
      end.compact
    end

end
