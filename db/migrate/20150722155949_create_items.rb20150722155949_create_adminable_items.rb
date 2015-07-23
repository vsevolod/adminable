class CreateAdminableItems < ActiveRecord::Migration
  def change
    create_table :adminable_items do |t|
      t.boolean :available
      t.float :cost
      t.integer :currency_id, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.string :name
      t.integer :brand_id, index: true, foreign_key: true
      t.text :description

      t.timestamps null: false
    end
  end
end
