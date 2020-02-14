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

ActiveRecord::Schema.define(version: 2020_02_11_173442) do

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "clues_available", default: 3
    t.integer "correct_counter", default: 1
    t.float "score"
  end

  create_table "players_questions", force: :cascade do |t|
    t.integer "player_id"
    t.integer "question_id"
    t.string "chosen_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.string "choices"
    t.string "correct_answer"
    t.integer "category_num"
  end

end
