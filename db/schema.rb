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

ActiveRecord::Schema.define(version: 20130725142305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: true do |t|
    t.integer  "employee_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.boolean  "admin"
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree

  create_table "merchant_cashouts", force: true do |t|
    t.integer  "merchant_id"
    t.integer  "cashout_sum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merchants", force: true do |t|
    t.integer  "employee_id"
    t.integer  "deposit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shift_row_assigns", force: true do |t|
    t.integer  "shift_row_id"
    t.integer  "def"
    t.integer  "shift_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shift_rows", force: true do |t|
    t.string   "title"
    t.integer  "row_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
  end

  create_table "shifts", force: true do |t|
    t.integer  "site_id"
    t.integer  "employee_id"
    t.integer  "balance"
    t.integer  "till"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.integer  "percent"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.text     "direction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shiftstatus", default: false
  end

end
