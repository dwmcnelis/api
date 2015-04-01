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

ActiveRecord::Schema.define(version: 20150325155121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "clients", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "first_name", limit: 40
    t.string   "last_name",  limit: 40
    t.string   "email",      limit: 254
    t.string   "phone",      limit: 40
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank"
    t.integer  "buzzes"
    t.integer  "status",                 default: 0
    t.integer  "level",                  default: 1
    t.string   "image_uid"
    t.string   "image_name"
  end

  create_table "conferences", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "short_name", limit: 254
    t.string   "full_name",  limit: 254
    t.uuid     "user_id"
    t.integer  "verified",   limit: 2,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credentials", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "password_digest",                  limit: 130
    t.string   "signature_nonce",                  limit: 90
    t.integer  "multi_factor",                     limit: 2,   default: 0, null: false
    t.string   "multi_factor_secret",              limit: 46
    t.integer  "multi_factor_counter",             limit: 2,   default: 0, null: false
    t.integer  "multi_factor_phone",               limit: 2,   default: 0, null: false
    t.string   "multi_factor_phone_number",        limit: 25
    t.integer  "multi_factor_phone_backup",        limit: 2,   default: 0, null: false
    t.string   "multi_factor_phone_backup_number", limit: 25
    t.integer  "multi_factor_authenticator",       limit: 2,   default: 0, null: false
    t.text     "multi_factor_backup_codes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "divisions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "short_name", limit: 254
    t.string   "full_name",  limit: 254
    t.uuid     "user_id"
    t.integer  "verified",   limit: 2,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "short_name", limit: 254
    t.string   "full_name",  limit: 254
    t.uuid     "user_id"
    t.integer  "verified",   limit: 2,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "as",          limit: 128
    t.uuid     "tag_id"
    t.uuid     "tagged_id"
    t.string   "tagged_type", limit: 128
    t.uuid     "tagger_id"
    t.string   "tagger_type", limit: 128
    t.integer  "importance",  limit: 2,   default: 0, null: false
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["as", "tag_id", "tagged_id", "tagged_type", "tagger_id", "tagger_type"], name: "taggings_unique_index", unique: true, using: :btree
  add_index "taggings", ["as", "tagged_id", "tagged_type"], name: "taggings_index", using: :btree

  create_table "tags", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "as",             limit: 128
    t.string   "name",           limit: 128
    t.string   "description",    limit: 128
    t.integer  "taggings_count",             default: 0
    t.string   "image_uid",      limit: 254
    t.string   "image_name",     limit: 254
    t.uuid     "user_id"
    t.integer  "verified",       limit: 2,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["as", "name", "description"], name: "tags_index", unique: true, using: :btree

  create_table "teams", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",          limit: 254
    t.string   "slug",          limit: 254
    t.integer  "level",         limit: 2,   default: 0, null: false
    t.integer  "kind",          limit: 2,   default: 0, null: false
    t.uuid     "league_id"
    t.uuid     "division_id"
    t.date     "founded"
    t.string   "location",      limit: 254
    t.string   "arena",         limit: 254
    t.uuid     "user_id"
    t.integer  "verified",      limit: 2,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aliases"
    t.uuid     "conference_id"
  end

  add_index "teams", ["name", "level", "kind"], name: "teams_index", unique: true, using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "username",   limit: 254
    t.string   "first_name", limit: 40
    t.string   "last_name",  limit: 40
    t.date     "dob"
    t.integer  "gender",     limit: 2,   default: 0, null: false
    t.integer  "admin",      limit: 2,   default: 0, null: false
    t.integer  "alpha",      limit: 2,   default: 0, null: false
    t.integer  "beta",       limit: 2,   default: 0, null: false
    t.integer  "banned",     limit: 2,   default: 0, null: false
    t.integer  "tos",        limit: 2,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
