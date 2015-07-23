# DB:
#   available: boolean
#   cost: float
#   currency: references
#   category: references
#   name: string
#   brand: references
#   description: text
class Adminable::Item < ActiveRecord::Base
  belongs_to :currency, class_name: 'Adminable::Dictionary'
  belongs_to :category
  belongs_to :brand, class_name: 'Adminable::Dictionary'
  has_many :galleries, as: :galleryable, dependent: :destroy

  accepts_nested_attributes_for :galleries, allow_destroy: true

  validates :name, presence: true
end
