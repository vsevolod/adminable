class AddVideoProcessingToGalleryObject < ActiveRecord::Migration
  def change
    add_column :gallery_objects, :video_processing, :boolean
  end
end
