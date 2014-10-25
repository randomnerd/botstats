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

ActiveRecord::Schema.define(version: 20141025035957) do

  create_table "balance_changes", force: true do |t|
    t.integer  "currency_id"
    t.integer  "old_balance", limit: 8
    t.integer  "new_balance", limit: 8
    t.datetime "created_at"
  end

  add_index "balance_changes", ["currency_id"], name: "index_balance_changes_on_currency_id"

  create_table "currencies", force: true do |t|
    t.integer  "exchange_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "deposit_address"
    t.integer  "balance",         limit: 8
  end

  add_index "currencies", ["deposit_address"], name: "index_currencies_on_deposit_address"
  add_index "currencies", ["exchange_id"], name: "index_currencies_on_exchange_id"
  add_index "currencies", ["name"], name: "index_currencies_on_name"

  create_table "exchanges", force: true do |t|
    t.string   "name"
    t.string   "api_key"
    t.string   "api_secret"
    t.string   "api_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_adapter"
    t.string   "username"
    t.boolean  "enable_updates"
  end

  create_table "orders", force: true do |t|
    t.integer  "exchange_id"
    t.integer  "currency_id"
    t.integer  "market_id"
    t.boolean  "sell",                  default: false
    t.integer  "amount",      limit: 8
    t.integer  "rate",        limit: 8
    t.integer  "remain",      limit: 8
    t.integer  "fee",         limit: 8
    t.string   "internal_id"
    t.datetime "closed_at"
    t.boolean  "closed",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["closed"], name: "index_orders_on_closed"
  add_index "orders", ["currency_id"], name: "index_orders_on_currency_id"
  add_index "orders", ["exchange_id"], name: "index_orders_on_exchange_id"
  add_index "orders", ["internal_id"], name: "index_orders_on_internal_id"
  add_index "orders", ["market_id"], name: "index_orders_on_market_id"

  create_table "trade_pairs", force: true do |t|
    t.integer  "exchange_id"
    t.integer  "currency_id"
    t.integer  "market_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
