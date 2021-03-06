# DB
#   name: string
#   enabled: boolean
#   page_id: integer
class Gallery < ActiveRecord::Base
  belongs_to :galleryable, polymorphic: true
  has_many :gallery_objects, lambda{order(position: :asc)}, dependent: :destroy

  accepts_nested_attributes_for :gallery_objects, allow_destroy: true

  def gallery_object
    gallery_objects.first
  end
end
