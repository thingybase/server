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

ActiveRecord::Schema[8.0].define(version: 2025_08_10_211417) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.uuid "uuid"
    t.index ["user_id"], name: "index_accounts_on_user_id"
    t.index ["uuid"], name: "index_accounts_on_uuid", unique: true
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "query_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "token", null: false
    t.string "email", null: false
    t.string "name"
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "container", default: false, null: false
    t.bigint "parent_id"
    t.string "icon_key"
    t.uuid "uuid", null: false
    t.datetime "expires_at", precision: nil
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "item_id"
    t.index ["account_id"], name: "index_labels_on_account_id"
    t.index ["item_id"], name: "index_labels_on_item_id"
    t.index ["user_id"], name: "index_labels_on_user_id"
    t.index ["uuid"], name: "index_labels_on_uuid", unique: true
  end

  create_table "loanable_items", force: :cascade do |t|
    t.bigint "loanable_list_id", null: false
    t.bigint "user_id", null: false
    t.bigint "account_id", null: false
    t.bigint "item_id", null: false
    t.uuid "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_loanable_items_on_account_id"
    t.index ["item_id"], name: "index_loanable_items_on_item_id"
    t.index ["loanable_list_id"], name: "index_loanable_items_on_loanable_list_id"
    t.index ["user_id"], name: "index_loanable_items_on_user_id"
    t.index ["uuid"], name: "index_loanable_items_on_uuid", unique: true
  end

  create_table "loanable_list_member_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "loanable_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loanable_list_id"], name: "index_loanable_list_member_requests_on_loanable_list_id"
    t.index ["user_id"], name: "index_loanable_list_member_requests_on_user_id"
  end

  create_table "loanable_list_members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "loanable_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loanable_list_id"], name: "index_loanable_list_members_on_loanable_list_id"
    t.index ["user_id"], name: "index_loanable_list_members_on_user_id"
  end

  create_table "loanable_lists", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.uuid "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_loanable_lists_on_account_id"
    t.index ["user_id"], name: "index_loanable_lists_on_user_id"
    t.index ["uuid"], name: "index_loanable_lists_on_uuid", unique: true
  end

  create_table "member_requests", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "user_id"], name: "index_member_requests_on_account_id_and_user_id", unique: true
    t.index ["account_id"], name: "index_member_requests_on_account_id"
    t.index ["user_id"], name: "index_member_requests_on_user_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "new_item_container_id"
    t.index ["account_id"], name: "index_moves_on_account_id"
    t.index ["new_item_container_id"], name: "index_moves_on_new_item_container_id"
    t.index ["user_id"], name: "index_moves_on_user_id"
    t.index ["uuid"], name: "index_moves_on_uuid", unique: true
  end

  create_table "nopassword_secrets", force: :cascade do |t|
    t.string "data_digest", null: false
    t.string "code_digest", null: false
    t.datetime "expires_at", null: false
    t.integer "remaining_attempts", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_digest"], name: "index_nopassword_secrets_on_data_digest", unique: true
  end

  create_table "phone_number_claims", force: :cascade do |t|
    t.string "phone_number", null: false
    t.string "code", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_phone_number_claims_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.string "plan_type", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_subscriptions_on_account_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "invitations", "accounts"
  add_foreign_key "invitations", "users"
  add_foreign_key "items", "accounts"
  add_foreign_key "items", "items", column: "parent_id"
  add_foreign_key "items", "users"
  add_foreign_key "labels", "accounts"
  add_foreign_key "labels", "users"
  add_foreign_key "loanable_items", "accounts"
  add_foreign_key "loanable_items", "items"
  add_foreign_key "loanable_items", "loanable_lists"
  add_foreign_key "loanable_items", "users"
  add_foreign_key "loanable_list_member_requests", "loanable_lists"
  add_foreign_key "loanable_list_member_requests", "users"
  add_foreign_key "loanable_list_members", "loanable_lists"
  add_foreign_key "loanable_list_members", "users"
  add_foreign_key "loanable_lists", "accounts"
  add_foreign_key "loanable_lists", "users"
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
  add_foreign_key "subscriptions", "accounts"
  add_foreign_key "subscriptions", "users"
end
