class RenameBlogsToPosts < ActiveRecord::Migration
  def change
    rename_table :blogs, :posts
  end
end
