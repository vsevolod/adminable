class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.datetime :published_at
      t.text :content
      t.boolean :available

      t.timestamps null: false
    end
  end
end
