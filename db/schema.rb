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

ActiveRecord::Schema.define(version: 20180331131603) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string   "prof_id"
    t.integer  "tool_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "quantity"
    t.boolean  "confirmed",  default: false
    t.integer  "lab_id"
    t.string   "goal"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "categories_tools", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "tool_id",     null: false
    t.index ["category_id", "tool_id"], name: "index_categories_tools_on_category_id_and_tool_id"
    t.index ["tool_id", "category_id"], name: "index_categories_tools_on_tool_id_and_category_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",         default: 0, null: false
    t.integer  "attempts",         default: 0, null: false
    t.text     "handler",                      null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "progress_stage"
    t.integer  "progress_current", default: 0
    t.integer  "progress_max",     default: 0
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "documentations", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.integer  "tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "lab_technicals", force: :cascade do |t|
    t.integer  "lab_id"
    t.integer  "technical_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "labs", force: :cascade do |t|
    t.string   "name"
    t.string   "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "labs_tools", id: false, force: :cascade do |t|
    t.integer "lab_id",  null: false
    t.integer "tool_id", null: false
    t.index ["lab_id", "tool_id"], name: "index_labs_tools_on_lab_id_and_tool_id"
    t.index ["tool_id", "lab_id"], name: "index_labs_tools_on_tool_id_and_lab_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "picture"
    t.integer  "tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "body"
    t.integer  "prof_id"
    t.integer  "tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profs", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name",                   default: "",    null: false
    t.string   "surname",                default: "",    null: false
    t.boolean  "authorized",             default: false
    t.datetime "deleted_at"
    t.string   "provider"
    t.string   "uid"
    t.index ["confirmation_token"], name: "index_profs_on_confirmation_token", unique: true
    t.index ["email"], name: "index_profs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_profs_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_profs_on_unlock_token", unique: true
    t.index [nil], name: "index_profs_on_deletd_at"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "mail"
    t.string   "password"
    t.string   "client"
    t.string   "secret"
  end

  create_table "technicals", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tempbooks", force: :cascade do |t|
    t.string   "prof_id"
    t.integer  "tool_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "quantity"
    t.integer  "lab_id"
    t.string   "goal"
  end

  create_table "tool_translations", force: :cascade do |t|
    t.integer  "tool_id",     null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.string   "description"
    t.index ["locale"], name: "index_tool_translations_on_locale"
    t.index ["tool_id"], name: "index_tool_translations_on_tool_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string   "photo"
    t.string   "identifier"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

end
