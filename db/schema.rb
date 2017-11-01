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

ActiveRecord::Schema.define(version: 20171101153110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_store_events", id: :serial, force: :cascade do |t|
    t.string "stream", null: false
    t.string "event_type", null: false
    t.string "event_id", null: false
    t.text "metadata"
    t.text "data", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
    t.index ["event_id"], name: "index_event_store_events_on_event_id", unique: true
    t.index ["event_type"], name: "index_event_store_events_on_event_type"
    t.index ["stream"], name: "index_event_store_events_on_stream"
  end

  create_table "project_details", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name"
    t.integer "estimation_in_hours"
  end

  create_table "projects", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name"
    t.integer "estimation_in_hours"
  end

end
