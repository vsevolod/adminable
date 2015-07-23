class AddPositionToPages < ActiveRecord::Migration
  def change
    add_column :adminable_pages, :position, :integer
  end
end
