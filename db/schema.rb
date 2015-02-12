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

ActiveRecord::Schema.define(version: 20150211233904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "vehicle"
    t.string   "name_of_user"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

  create_table "days", force: true do |t|
    t.string "name"
  end

  create_table "days_jobs", id: false, force: true do |t|
    t.integer "day_id"
    t.integer "job_id"
  end

  add_index "days_jobs", ["day_id", "job_id"], name: "index_days_jobs_on_day_id_and_job_id", unique: true, using: :btree

  create_table "days_users", id: false, force: true do |t|
    t.integer "day_id"
    t.integer "user_id"
  end

  add_index "days_users", ["day_id", "user_id"], name: "index_days_users_on_day_id_and_user_id", unique: true, using: :btree

  create_table "experience_items", force: true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.string   "location"
    t.string   "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "current"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.integer  "user_id"
    t.string   "name",                      null: false
    t.text     "description"
    t.boolean  "employer_provides_vehicle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "category_id"
    t.string   "summary"
    t.integer  "rate_hourly_pounds"
    t.integer  "rate_hourly_pence"
    t.integer  "rate_commission_pounds"
    t.integer  "rate_commission_pence"
    t.boolean  "rate_not_included"
    t.integer  "rate_max"
    t.integer  "rate_min"
    t.string   "rate_interval"
  end

  add_index "jobs", ["category_id"], name: "index_jobs_on_category_id", using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "jobs_shiftslots", id: false, force: true do |t|
    t.integer "job_id"
    t.integer "shiftslot_id"
  end

  add_index "jobs_shiftslots", ["job_id", "shiftslot_id"], name: "index_jobs_shiftslots_on_job_id_and_shiftslot_id", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "profileviews", force: true do |t|
    t.integer  "viewer_id"
    t.integer  "viewee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profileviews", ["viewee_id"], name: "index_profileviews_on_viewee_id", using: :btree
  add_index "profileviews", ["viewer_id"], name: "index_profileviews_on_viewer_id", using: :btree

  create_table "purchases", force: true do |t|
    t.integer  "buyer_id"
    t.integer  "driver_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["buyer_id"], name: "index_purchases_on_buyer_id", using: :btree
  add_index "purchases", ["driver_id"], name: "index_purchases_on_driver_id", using: :btree

  create_table "qualification_items", force: true do |t|
    t.integer  "user_id"
    t.string   "qualification_title"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "current"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shiftslots", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shiftslots_users", id: false, force: true do |t|
    t.integer "shiftslot_id"
    t.integer "user_id"
  end

  add_index "shiftslots_users", ["shiftslot_id", "user_id"], name: "index_shiftslots_users_on_shiftslot_id_and_user_id", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "summary"
    t.text     "long_description"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "country"
    t.string   "photo"
    t.string   "stripe_customer_id"
    t.string   "phone_number"
    t.integer  "category_id"
    t.string   "activity_level"
    t.boolean  "valid_license"
  end

  add_index "users", ["category_id"], name: "index_users_on_category_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
