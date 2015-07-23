class CreateAdminableCategories < ActiveRecord::Migration
  def change
    create_table :adminable_categories do |t|
      t.string :name
      t.hstore :data
      t.string :ancestry
      t.integer :position

      t.timestamps null: false
    end
    add_attachment :adminable_categories, :photo
  end
end
