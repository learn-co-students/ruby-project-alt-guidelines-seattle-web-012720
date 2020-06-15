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

ActiveRecord::Schema.define(version: 2020_02_13_000830) do

  create_table "ghosts", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.integer "power", default: 1
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.boolean "unlocked"
  end

  create_table "residents", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.integer "sanity"
    t.boolean "book"
    t.boolean "knowledge"
  end

  create_table "spooks", force: :cascade do |t|
    t.integer "ghost_id"
    t.integer "resident_id"
  end

end
