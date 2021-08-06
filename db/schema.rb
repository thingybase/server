# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_05_162344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid"
    t.index ["user_id"], name: "index_accounts_on_user_id"
    t.index ["uuid"], name: "index_accounts_on_uuid", unique: true
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "name"
    t.string "secret"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id"
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

  create_table "item_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "item_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "item_desc_idx"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "container", default: false, null: false
    t.bigint "parent_id"
    t.string "icon_key"
    t.uuid "uuid", null: false
    t.datetime "expires_at"
    t.integer "items_count", default: 0, null: false
    t.integer "containers_count", default: 0, null: false
    t.index ["account_id"], name: "index_items_on_account_id"
    t.index ["container"], name: "index_items_on_container"
    t.index ["expires_at"], name: "index_items_on_expires_at"
    t.index ["parent_id"], name: "index_items_on_parent_id"
    t.index ["user_id"], name: "index_items_on_user_id"
    t.index ["uuid"], name: "index_items_on_uuid", unique: true
  end

  create_table "labels", force: :cascade do |t|
    t.string "text"
    t.uuid "uuid", null: false
    t.bigint "user_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id"
    t.index ["account_id"], name: "index_labels_on_account_id"
    t.index ["item_id"], name: "index_labels_on_item_id"
    t.index ["user_id"], name: "index_labels_on_user_id"
    t.index ["uuid"], name: "index_labels_on_uuid", unique: true
  end

  create_table "member_requests", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "user_id"], name: "index_member_requests_on_account_id_and_user_id", unique: true
    t.index ["account_id"], name: "index_member_requests_on_account_id"
    t.index ["user_id"], name: "index_member_requests_on_user_id"
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

  create_table "movements", force: :cascade do |t|
    t.uuid "uuid"
    t.bigint "user_id", null: false
    t.bigint "account_id", null: false
    t.bigint "move_id", null: false
    t.bigint "origin_id", null: false
    t.bigint "destination_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_movements_on_account_id"
    t.index ["destination_id"], name: "index_movements_on_destination_id"
    t.index ["move_id"], name: "index_movements_on_move_id"
    t.index ["origin_id"], name: "index_movements_on_origin_id"
    t.index ["user_id"], name: "index_movements_on_user_id"
  end

  create_table "moves", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.uuid "uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "new_item_container_id"
    t.index ["account_id"], name: "index_moves_on_account_id"
    t.index ["new_item_container_id"], name: "index_moves_on_new_item_container_id"
    t.index ["user_id"], name: "index_moves_on_user_id"
    t.index ["uuid"], name: "index_moves_on_uuid", unique: true
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
  add_foreign_key "invitations", "accounts"
  add_foreign_key "invitations", "users"
  add_foreign_key "items", "accounts"
  add_foreign_key "items", "items", column: "parent_id"
  add_foreign_key "items", "users"
  add_foreign_key "labels", "accounts"
  add_foreign_key "labels", "users"
  add_foreign_key "members", "accounts"
  add_foreign_key "members", "users"
  add_foreign_key "movements", "accounts"
  add_foreign_key "movements", "items", column: "destination_id"
  add_foreign_key "movements", "items", column: "origin_id"
  add_foreign_key "movements", "moves"
  add_foreign_key "movements", "users"
  add_foreign_key "moves", "accounts"
  add_foreign_key "moves", "items", column: "new_item_container_id"
  add_foreign_key "moves", "users"
  add_foreign_key "phone_number_claims", "users"
end
