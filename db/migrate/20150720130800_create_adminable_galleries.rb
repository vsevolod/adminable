class CreateAdminableGalleries < ActiveRecord::Migration
  def change
    create_table :adminable_galleries do |t|
      t.string :name
      t.boolean :enabled
      t.references :galleryable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
