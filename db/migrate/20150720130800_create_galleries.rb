class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.boolean :enabled
      t.references :galleryable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
