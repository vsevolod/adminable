class CreateAdminableBanners < ActiveRecord::Migration

  def self.up
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    create_table :adminable_banners do |t|
      t.integer :position
      t.string :banner_type
      t.hstore :data
      t.string :url
      t.boolean :available

      t.timestamps null: false
    end

    add_attachment :adminable_banners, :photo
  end

  def self.down
    drop_table :adminable_banners
    execute "DROP EXTENSION IF EXISTS hstore"
  end
end
