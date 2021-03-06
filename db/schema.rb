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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20170507034144) do
=======
ActiveRecord::Schema.define(version: 20170517193630) do
>>>>>>> d4c54198d36fd4919a1a0757b91b962273d56ba4

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer  "story_id"
    t.string   "photo"
    t.string   "caption"
    t.integer  "prev_id"
    t.integer  "next_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["next_id"], name: "index_cards_on_next_id", using: :btree
    t.index ["prev_id"], name: "index_cards_on_prev_id", using: :btree
    t.index ["story_id"], name: "index_cards_on_story_id", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "image_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "image_id"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.integer "impressionable_id"
    t.string  "impressionable_type"
    t.integer "user_id"
    t.string  "ip_address"
    t.index ["impressionable_id"], name: "index_impressions_on_impressionable_id", using: :btree
    t.index ["ip_address"], name: "index_impressions_on_ip_address", using: :btree
    t.index ["user_id"], name: "index_impressions_on_user_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "lat"
    t.string   "lng"
    t.string   "place_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "stories", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "featured"
    t.integer  "place_id"
    t.index ["user_id"], name: "index_stories_on_user_id", using: :btree
  end

  create_table "story_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "story_loves", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_story_loves_on_story_id", using: :btree
    t.index ["user_id", "story_id"], name: "index_story_loves_on_user_id_and_story_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_story_loves_on_user_id", using: :btree
  end

  create_table "trending_places", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "batch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_trending_places_on_place_id", using: :btree
  end

  create_table "trending_stories", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "batch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_trending_stories_on_story_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "cards", "stories"
  add_foreign_key "identities", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "story_loves", "stories"
  add_foreign_key "story_loves", "users"
end
