class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.hstore :data
      t.string :ancestry
      t.integer :position

      t.timestamps null: false
    end
    add_attachment :categories, :photo
  end
end
