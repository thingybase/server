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

ActiveRecord::Schema.define(version: 2019_02_10_073553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "name"
    t.string "secret"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "container_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "container_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "container_desc_idx"
  end

  create_table "containers", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "account_id"
    t.bigint "user_id"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_containers_on_account_id"
    t.index ["parent_id"], name: "index_containers_on_parent_id"
    t.index ["user_id"], name: "index_containers_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "token", null: false
    t.string "email", null: false
    t.string "name"
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_invitations_on_account_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "container_id"
    t.index ["account_id"], name: "index_items_on_account_id"
    t.index ["container_id"], name: "index_items_on_container_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "text"
    t.uuid "uuid", null: false
    t.bigint "user_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "labelable_type"
    t.bigint "labelable_id"
    t.index ["account_id"], name: "index_labels_on_account_id"
    t.index ["labelable_type", "labelable_id"], name: "index_labels_on_labelable_type_and_labelable_id"
    t.index ["user_id"], name: "index_labels_on_user_id"
    t.index ["uuid"], name: "index_labels_on_uuid", unique: true
  end

  create_table "members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_members_on_account_id"
    t.index ["user_id", "account_id"], name: "index_members_on_user_id_and_account_id", unique: true
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "phone_number_claims", force: :cascade do |t|
    t.string "phone_number", null: false
    t.string "code", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_phone_number_claims_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "api_keys", "users"
  add_foreign_key "containers", "accounts"
  add_foreign_key "containers", "containers", column: "parent_id"
  add_foreign_key "containers", "users"
  add_foreign_key "invitations", "accounts"
  add_foreign_key "invitations", "users"
  add_foreign_key "items", "accounts"
  add_foreign_key "items", "containers"
  add_foreign_key "items", "users"
  add_foreign_key "labels", "accounts"
  add_foreign_key "labels", "users"
  add_foreign_key "members", "accounts"
  add_foreign_key "members", "users"
  add_foreign_key "phone_number_claims", "users"
end
