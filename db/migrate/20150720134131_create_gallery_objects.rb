class CreateGalleryObjects < ActiveRecord::Migration
  def change
    create_table :gallery_objects do |t|
      t.string :name
      t.text :description
      t.references :gallery

      t.timestamps null: false
    end

    add_attachment :gallery_objects, :video
    add_attachment :gallery_objects, :photo
  end
end
