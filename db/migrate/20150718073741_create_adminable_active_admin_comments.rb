class CreateAdminableActiveAdminComments < ActiveRecord::Migration
  def self.up
    create_table :adminable_active_admin_comments do |t|
      t.string :namespace
      t.text   :body
      t.string :resource_id,   null: false
      t.string :resource_type, null: false
      t.references :author, polymorphic: true
      t.timestamps
    end
    add_index :adminable_active_admin_comments, [:namespace]
    add_index :adminable_active_admin_comments, [:author_type, :author_id]
    add_index :adminable_active_admin_comments, [:resource_type, :resource_id]
  end

  def self.down
    drop_table :adminable_active_admin_comments
  end
end
