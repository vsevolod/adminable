class CreateAdminableDictionaries < ActiveRecord::Migration
  def change
    create_table :adminable_dictionaries do |t|
      t.string  :name
      t.string  :value
      t.string  :tag
      t.string  :ancestry
      t.integer :ancestry_depth
      t.hstore  :data
      t.integer :position
      t.boolean :available, null: false, default: true

      t.timestamps null: false
    end
  end
end
