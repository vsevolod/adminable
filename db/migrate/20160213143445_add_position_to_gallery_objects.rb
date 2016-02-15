class AddPositionToGalleryObjects < ActiveRecord::Migration
  def change
    add_column :gallery_objects, :position, :integer
  end
end
