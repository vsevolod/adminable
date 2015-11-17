class AddObjectToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :object_id, :integer
    add_column :banners, :object_type, :string
  end
end
