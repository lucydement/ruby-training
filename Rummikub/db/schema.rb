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

ActiveRecord::Schema.define(version: 20141126222539) do

  create_table "games", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.integer  "game_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id"

  create_table "tile_sets", force: true do |t|
    t.integer  "game_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tile_sets", ["game_id"], name: "index_tile_sets_on_game_id"

  create_table "tiles", force: true do |t|
    t.string   "colour",      null: false
    t.integer  "number",      null: false
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "tile_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tiles", ["game_id"], name: "index_tiles_on_game_id"
  add_index "tiles", ["player_id"], name: "index_tiles_on_player_id"
  add_index "tiles", ["tile_set_id"], name: "index_tiles_on_tile_set_id"

end
