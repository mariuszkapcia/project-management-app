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

ActiveRecord::Schema.define(version: 20190314215625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "encryption_keys", force: :cascade do |t|
    t.string "cipher"
    t.binary "key"
    t.string "identifier"
    t.index ["identifier", "cipher"], name: "index_encryption_keys_on_identifier_and_cipher", unique: true
  end

  create_table "event_store_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "event_type", null: false
    t.text "metadata"
    t.text "data", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
  end

  create_table "event_store_events_in_streams", id: :serial, force: :cascade do |t|
    t.string "stream", null: false
    t.integer "position"
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "ui_developer_list_read_model", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "fullname"
    t.string "email"
    t.index ["email"], name: "index_ui_developer_list_read_model_on_email", unique: true
  end

  create_table "ui_notification_list_read_model", force: :cascade do |t|
    t.text "message"
  end

  create_table "ui_project_aproximate_end_read_model", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.integer "estimation"
    t.jsonb "working_hours", default: {}
    t.datetime "approximate_end"
  end

  create_table "ui_project_details_read_model", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name"
    t.integer "estimation_in_hours"
    t.jsonb "developers", default: []
    t.datetime "deadline"
  end

  create_table "ui_project_list_read_model", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name"
  end

end
