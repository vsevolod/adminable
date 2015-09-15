class AddHstoreToPage < ActiveRecord::Migration
  def change
    add_column :pages, :data, :hstore
  end
end
