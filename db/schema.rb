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

ActiveRecord::Schema.define(version: 20150721033807) do

  create_table "careers", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "careers_pcs", id: false, force: :cascade do |t|
    t.integer "career_id"
    t.integer "pc_id"
  end

  create_table "careers_skills", id: false, force: :cascade do |t|
    t.integer "career_id"
    t.integer "skill_id"
  end

  create_table "gms", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "gms", ["email"], name: "index_gms_on_email", unique: true
  add_index "gms", ["reset_password_token"], name: "index_gms_on_reset_password_token", unique: true

  create_table "pcs", force: :cascade do |t|
    t.string   "name"
    t.integer  "xp"
    t.integer  "credits"
    t.integer  "brawn"
    t.integer  "agility"
    t.integer  "intellect"
    t.integer  "cunning"
    t.integer  "willpower"
    t.integer  "presence"
    t.integer  "wounds_thresh"
    t.integer  "wounds_current"
    t.integer  "strain_thresh"
    t.integer  "strain_current"
    t.integer  "critical"
    t.integer  "soak"
    t.string   "obligation_type"
    t.integer  "obligation_amount"
    t.integer  "player_id"
    t.integer  "race_id"
    t.integer  "career_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "status"
  end

  add_index "pcs", ["career_id"], name: "index_pcs_on_career_id"
  add_index "pcs", ["race_id"], name: "index_pcs_on_race_id"

  create_table "pcs_sessions", force: :cascade do |t|
    t.integer "pcs_id"
    t.integer "sessions_id"
  end

  create_table "pcs_skills", force: :cascade do |t|
    t.integer "pc_id"
    t.integer "skill_id"
    t.integer "rank",     default: 0
    t.boolean "cskill",   default: false
  end

  create_table "pcs_specializations", id: false, force: :cascade do |t|
    t.integer "pc_id"
    t.integer "specialization_id"
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["user_id"], name: "index_players_on_user_id"

  create_table "races", force: :cascade do |t|
    t.string   "name"
    t.integer  "xp"
    t.integer  "brawn"
    t.integer  "agility"
    t.integer  "intellect"
    t.integer  "cunning"
    t.integer  "willpower"
    t.integer  "presence"
    t.integer  "wounds_thresh"
    t.integer  "strain_thresh"
    t.string   "bonus"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.string   "attrib"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills_specializations", id: false, force: :cascade do |t|
    t.integer "skill_id"
    t.integer "specialization_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.string   "name"
    t.text     "descriptin"
    t.integer  "career_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
