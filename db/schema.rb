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

ActiveRecord::Schema.define(version: 20160723200218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_emails", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  add_index "client_emails", ["product_id"], name: "index_client_emails_on_product_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "customer_responses", force: :cascade do |t|
    t.integer  "client_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "message_id"
  end

  add_index "customer_responses", ["client_id"], name: "index_customer_responses_on_client_id", using: :btree
  add_index "customer_responses", ["message_id"], name: "index_customer_responses_on_message_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "sms_message"
    t.string   "user_number"
    t.string   "user_name"
    t.string   "product_name"
    t.string   "review_redirect_url"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "customer_response_id"
  end

  add_index "messages", ["customer_response_id"], name: "index_messages_on_customer_response_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "amazon_review_url"
    t.integer  "amazon_id"
    t.integer  "review_count",      default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "products_id"
    t.string   "name"
    t.string   "phone_number"
    t.integer  "reviews_given"
    t.integer  "reviews_asked_for"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "users", ["products_id"], name: "index_users_on_products_id", using: :btree

  create_table "webhooks", force: :cascade do |t|
    t.text     "fulldata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customer_responses", "messages"
  add_foreign_key "messages", "customer_responses"
end
