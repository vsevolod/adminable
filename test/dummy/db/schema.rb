# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150722155949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "adminable_banners", force: :cascade do |t|
    t.integer  "position"
    t.string   "banner_type"
    t.hstore   "data"
    t.string   "url"
    t.boolean  "available"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "adminable_categories", force: :cascade do |t|
    t.string   "name"
    t.hstore   "data"
    t.string   "ancestry"
    t.integer  "position"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "adminable_dictionaries", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.string   "tag"
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.hstore   "data"
    t.integer  "position"
    t.boolean  "available",      default: true, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "adminable_galleries", force: :cascade do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.integer  "galleryable_id"
    t.string   "galleryable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "adminable_galleries", ["galleryable_id", "galleryable_type"], name: "adminable_galleriable", using: :btree

  create_table "adminable_gallery_objects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "gallery_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "adminable_items", force: :cascade do |t|
    t.boolean  "available"
    t.float    "cost"
    t.integer  "currency_id"
    t.integer  "adminable_category_id"
    t.string   "name"
    t.integer  "brand_id"
    t.text     "description"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "adminable_items", ["adminable_category_id"], name: "index_adminable_items_on_adminable_category_id", using: :btree
  add_index "adminable_items", ["brand_id"], name: "index_adminable_items_on_brand_id", using: :btree
  add_index "adminable_items", ["currency_id"], name: "index_adminable_items_on_currency_id", using: :btree

  create_table "adminable_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.string   "tag"
    t.text     "content"
    t.string   "url"
    t.json     "options"
    t.boolean  "available",  default: true, null: false
    t.string   "ancestry"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "position"
  end

  add_index "adminable_pages", ["ancestry"], name: "index_adminable_pages_on_ancestry", using: :btree

  create_table "assets", force: :cascade do |t|
    t.string   "storage_uid"
    t.string   "storage_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "storage_width"
    t.integer  "storage_height"
    t.float    "storage_aspect_ratio"
    t.integer  "storage_depth"
    t.string   "storage_format"
    t.string   "storage_mime_type"
    t.string   "storage_size"
  end

  add_foreign_key "adminable_items", "adminable_categories"
end
