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

ActiveRecord::Schema.define(version: 20151019151817) do

  create_table "categories", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "comment",    limit: 255
    t.integer  "product_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity",   limit: 4
    t.integer "product_id", limit: 4
    t.integer "order_id",   limit: 4
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "Status",         limit: 255, default: "Pending"
    t.integer  "total",          limit: 4
    t.integer  "vat",            limit: 4
    t.integer  "delivery_cost",  limit: 4
    t.integer  "user_id",        limit: 4
    t.string   "notes",          limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "transaction_id", limit: 255
    t.string   "invoice",        limit: 255
    t.integer  "pickup_time",    limit: 4,   default: 0
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.string   "description",                limit: 255
    t.float    "price",                      limit: 24
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "status",                     limit: 255, default: "available"
    t.string   "product_image_file_name",    limit: 255
    t.string   "product_image_content_type", limit: 255
    t.integer  "product_image_file_size",    limit: 4
    t.datetime "product_image_updated_at"
    t.integer  "category_id",                limit: 4
    t.integer  "prep_time",                  limit: 4,   default: 12
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",          limit: 255
    t.string   "last_name",           limit: 255
    t.string   "email",               limit: 255
    t.string   "room_no",             limit: 255
    t.string   "ext",                 limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "password_digest",     limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.string   "role",                limit: 255, default: "user"
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "products", "categories"
end
