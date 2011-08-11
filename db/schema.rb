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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110711034123) do

  create_table "bids", :force => true do |t|
    t.integer  "player_id"
    t.integer  "trade_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",      :default => false
  end

  create_table "bids_tokens", :force => true do |t|
    t.integer  "bid_id"
    t.integer  "token_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids_tokens", ["bid_id", "token_id"], :name => "index_bids_tokens_on_bid_id_and_token_id", :unique => true
  add_index "bids_tokens", ["bid_id"], :name => "index_bids_tokens_on_bid_id"
  add_index "bids_tokens", ["token_id"], :name => "index_bids_tokens_on_token_id"

  create_table "characters", :force => true do |t|
    t.integer "series_id"
    t.integer "star_id"
    t.string  "name"
    t.string  "image"
    t.text    "description"
    t.integer "quantity"
    t.integer "quantity_issued"
  end

  create_table "packs", :force => true do |t|
    t.integer "player_id"
    t.integer "series_id"
    t.integer "quantity"
  end

  create_table "players", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "handle"
    t.string  "email"
    t.string  "encrypted_password"
    t.string  "password_salt"
    t.boolean "admin",              :default => false
  end

  create_table "series", :force => true do |t|
    t.string  "name"
    t.string  "image"
    t.text    "description"
    t.integer "tokens_per_pack"
    t.integer "packs_minted"
    t.integer "packs_issued"
    t.date    "release_date"
    t.date    "term_date"
  end

  create_table "stars", :force => true do |t|
    t.string "name"
    t.string "image"
    t.text   "description"
    t.date   "birth_date"
    t.date   "death_date"
    t.string "birthplace"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokens", :force => true do |t|
    t.integer "player_id"
    t.integer "character_id"
  end

  create_table "trades", :force => true do |t|
    t.integer  "player_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",      :default => false
  end

  create_table "trades_tokens", :force => true do |t|
    t.integer  "trade_id"
    t.integer  "token_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trades_tokens", ["token_id"], :name => "index_trades_tokens_on_token_id"
  add_index "trades_tokens", ["trade_id", "token_id"], :name => "index_trades_tokens_on_trade_id_and_token_id", :unique => true
  add_index "trades_tokens", ["trade_id"], :name => "index_trades_tokens_on_trade_id"

end
