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

ActiveRecord::Schema.define(version: 20160507040754) do

  create_table "datapoints", force: :cascade do |t|
    t.date     "day"
    t.float    "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "indicator_id"
  end

  add_index "datapoints", ["indicator_id"], name: "index_datapoints_on_indicator_id"

  create_table "indicators", force: :cascade do |t|
    t.string   "name"
    t.string   "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plot_families", force: :cascade do |t|
    t.string   "name"
    t.integer  "refresh_int_mins"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "plot_to_families", force: :cascade do |t|
    t.integer  "plot_id"
    t.integer  "plot_family_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "plots", force: :cascade do |t|
    t.string   "name"
    t.integer  "days_duration"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "dataset"
  end

  create_table "series", force: :cascade do |t|
    t.integer  "plot_id"
    t.integer  "indicator_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
