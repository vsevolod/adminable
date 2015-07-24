# DB
# name: string
# title: string
# tag :string
# content: text
# url: string
# ancestry (parent): string
# options: json
#   keywords: string
#   description: string
class Page < ActiveRecord::Base

  has_ancestry
  has_many :galleries, as: :galleryable, dependent: :destroy

  accepts_nested_attributes_for :galleries, allow_destroy: true
  
end
