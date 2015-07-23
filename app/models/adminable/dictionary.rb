# DB:
#   name: string
#   value: string
#   tag: string
#   ancestry: string
#   ancestry_depth: integer
#   data: hstore
#   available: boolean
class Adminable::Dictionary < ActiveRecord::Base

  has_ancestry cache_depth: true
  def self.[](tag)
    case tag.to_s
    when ''                 then self.where('TRUE = FALSE')
    else
      Adminable::Dictionary.find_by_tag(tag.to_s).try(:children)
    end
  end

  scope :by_priority, lambda{ order("position") }
  include Adminable::DictionaryColumns

  add_columns(:dictionary_fields)
  add_store_accessor

  validates :name, presence: true, uniqueness: {scope: [:ancestry]}
  validates :tag, uniqueness: true, if: Proc.new{|d| not d.tag.blank?}

  # Возвращает детей словаря, выбранного для селекта
  def get_select_dictionary_children
    model = self.variable_type.try(:value) == 'collection' ? self.reference_id : 'Dictionary'
    select_tag_text = self.select_tag.blank? ? self.select_tag_array : self.select_tag
    model == 'Adminable::Dictionary' ? model.constantize[select_tag_text] : model.capitalize.constantize.scoped
  end

  # Возвращает коллекцию значений для записи
  def get_collection
    get_select_dictionary_children.map{|d| self.reference_id.present? ? [d.name, d.id] : d.name}
  end

end
