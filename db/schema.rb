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

ActiveRecord::Schema.define(version: 20160721220046) do

  create_table "bills", force: :cascade do |t|
    t.string   "slug",          limit: 255,             null: false
    t.integer  "upvotes_count", limit: 4,   default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "guest_name",  limit: 255
    t.string   "guest_email", limit: 255
    t.text     "body",        limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "post_id",     limit: 4,     null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "debates", force: :cascade do |t|
    t.string   "slug",        limit: 255,             null: false
    t.integer  "alpha_count", limit: 4,   default: 0
    t.integer  "beta_count",  limit: 4,   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "opinions", force: :cascade do |t|
    t.string   "name",        limit: 255,   null: false
    t.text     "body",        limit: 65535
    t.string   "debate_slug", limit: 255,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "party_names", force: :cascade do |t|
    t.string   "slug",          limit: 255,             null: false
    t.string   "name",          limit: 255,             null: false
    t.integer  "upvotes_count", limit: 4,   default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "guest_name",    limit: 255
    t.string   "guest_email",   limit: 255
    t.string   "title",         limit: 255,                   null: false
    t.text     "body",          limit: 65535
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "board_slug",    limit: 255,                   null: false
    t.integer  "sequential_id", limit: 4
    t.integer  "upvotes_count", limit: 4,     default: 0
    t.boolean  "sticky",                      default: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "upvotes", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "upvotes", ["post_id", "user_id"], name: "index_upvotes_on_post_id_and_user_id", unique: true, using: :btree
  add_index "upvotes", ["post_id"], name: "index_upvotes_on_post_id", using: :btree
  add_index "upvotes", ["user_id"], name: "index_upvotes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "provider",               limit: 255,              null: false
    t.string   "uid",                    limit: 255,              null: false
    t.string   "name",                   limit: 255
    t.string   "image",                  limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "card",                   limit: 255
    t.integer  "sequential_id",          limit: 4
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
