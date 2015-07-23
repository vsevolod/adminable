class CreateAdminableGalleryObjects < ActiveRecord::Migration
  def change
    create_table :adminable_gallery_objects do |t|
      t.string :name
      t.text :description
      t.references :gallery

      t.timestamps null: false
    end

    add_attachment :adminable_gallery_objects, :video
    add_attachment :adminable_gallery_objects, :photo
  end
end
