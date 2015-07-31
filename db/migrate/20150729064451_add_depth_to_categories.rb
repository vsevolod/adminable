class AddDepthToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ancestry_depth, :integer
    add_column :pages, :ancestry_depth, :integer
  end
end
