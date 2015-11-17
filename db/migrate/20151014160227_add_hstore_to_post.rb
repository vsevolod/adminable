class AddHstoreToPost < ActiveRecord::Migration
  def change
    add_column :posts, :data, :hstore
  end
end
