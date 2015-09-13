# DB
# name: string
# title: string
# tag :string
# content: text
# url: string
# data: hstore
# ancestry (parent): string
# options: json
#   keywords: string
#   description: string
class Page < ActiveRecord::Base

  has_ancestry cache_depth: true
  has_many :galleries, as: :galleryable, dependent: :destroy

  accepts_nested_attributes_for :galleries, allow_destroy: true

  def self.[](tag)
    page = self.find_by_tag(tag.to_s)
    if page
      page.children.order(:position)
    else
      Page.where('TRUE = FALSE')
    end
  end

  scope :available, ->{ where(available: true) }

  include DictionaryColumns
  add_columns(:page_fields)
  add_store_accessor

  def to_param
    if self.title
      "#{self.id}-#{Russian.translit(self.title).gsub(/\W/, '_')}"
    else
      self.id.to_s
    end
  end

  
end
