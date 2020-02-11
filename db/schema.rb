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

ActiveRecord::Schema.define(version: 6) do

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "num_pizzas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "name"
  end

  create_table "pizzas_orders", id: false, force: :cascade do |t|
    t.integer "pizzas_id"
    t.integer "orders_id"
    t.index ["orders_id"], name: "index_pizzas_orders_on_orders_id"
    t.index ["pizzas_id"], name: "index_pizzas_orders_on_pizzas_id"
  end

  create_table "toppings", force: :cascade do |t|
    t.string "name"
  end

  create_table "toppings_pizzas", id: false, force: :cascade do |t|
    t.integer "toppings_id"
    t.integer "pizzas_id"
    t.index ["pizzas_id"], name: "index_toppings_pizzas_on_pizzas_id"
    t.index ["toppings_id"], name: "index_toppings_pizzas_on_toppings_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
