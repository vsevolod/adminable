class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.string :tag
      t.text :content
      t.string :url
      t.json :options
      t.boolean :available, null: false, default: true

      t.string :ancestry

      t.timestamps null: false
    end
    add_index :pages, :ancestry
  end
end
