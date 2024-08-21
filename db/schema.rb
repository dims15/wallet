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

ActiveRecord::Schema[7.2].define(version: 2024_08_20_091544) do
  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "account_type", null: false
    t.decimal "balance", precision: 16, scale: 2, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_number", null: false
    t.bigint "customers_id", null: false
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
    t.index ["customers_id"], name: "index_accounts_on_customers_id"
  end

  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.string "name", null: false
    t.datetime "birth_date", null: false
    t.string "phone", null: false
    t.string "address", null: false
    t.string "customer_type", null: false
    t.json "additional_info"
    t.datetime "last_login"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_customers_on_username", unique: true
  end

  create_table "transactions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "transaction_type", null: false
    t.decimal "amount", precision: 16, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_account_id"
    t.bigint "target_account_id"
    t.index ["source_account_id"], name: "index_transactions_on_source_account_id"
    t.index ["target_account_id"], name: "index_transactions_on_target_account_id"
  end

  add_foreign_key "accounts", "customers", column: "customers_id"
  add_foreign_key "transactions", "accounts", column: "source_account_id"
  add_foreign_key "transactions", "accounts", column: "target_account_id"
end
