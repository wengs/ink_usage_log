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

ActiveRecord::Schema.define(version: 20160308235227) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "colors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "colors", ["name"], name: "index_colors_on_name", using: :btree

  create_table "ink_usages", force: :cascade do |t|
    t.string   "lot_number",             limit: 255
    t.date     "exp_code"
    t.integer  "user_id",                limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "machine_part_number_id", limit: 4
  end

  add_index "ink_usages", ["exp_code"], name: "index_ink_usages_on_exp_code", using: :btree
  add_index "ink_usages", ["lot_number"], name: "index_ink_usages_on_lot_number", using: :btree
  add_index "ink_usages", ["machine_part_number_id"], name: "index_ink_usages_on_machine_part_number_id", using: :btree
  add_index "ink_usages", ["user_id"], name: "index_ink_usages_on_user_id", using: :btree

  create_table "machine_part_numbers", force: :cascade do |t|
    t.integer  "machine_id",     limit: 4
    t.integer  "part_number_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "machine_part_numbers", ["machine_id"], name: "index_machine_part_numbers_on_machine_id", using: :btree
  add_index "machine_part_numbers", ["part_number_id"], name: "index_machine_part_numbers_on_part_number_id", using: :btree

  create_table "machines", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "machines", ["name"], name: "index_machines_on_name", using: :btree

  create_table "part_numbers", force: :cascade do |t|
    t.string   "number",     limit: 255
    t.integer  "color_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
  end

  add_index "part_numbers", ["color_id"], name: "index_part_numbers_on_color_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.integer  "role_id",                limit: 4
    t.string   "authentication_token",   limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  create_table "wastes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "machine_id", limit: 4
    t.integer  "level",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "wastes", ["machine_id"], name: "index_wastes_on_machine_id", using: :btree
  add_index "wastes", ["user_id"], name: "index_wastes_on_user_id", using: :btree

  add_foreign_key "ink_usages", "machine_part_numbers"
  add_foreign_key "ink_usages", "users"
  add_foreign_key "machine_part_numbers", "machines"
  add_foreign_key "machine_part_numbers", "part_numbers"
  add_foreign_key "part_numbers", "colors"
  add_foreign_key "users", "roles"
  add_foreign_key "wastes", "machines"
  add_foreign_key "wastes", "users"
end
