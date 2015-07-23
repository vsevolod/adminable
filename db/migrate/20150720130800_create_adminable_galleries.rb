class CreateAdminableGalleries < ActiveRecord::Migration
  def change
    create_table :adminable_galleries do |t|
      t.string :name
      t.boolean :enabled
      t.references :galleryable, polymorphic: true

      t.timestamps null: false
    end
    add_index :adminable_galleries, [:galleryable_id, :galleryable_type], {name: 'adminable_galleriable'}
  end
end
