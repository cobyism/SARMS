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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110523214621) do

  create_table "activities", :force => true do |t|
    t.integer  "unit_id"
    t.string   "name"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assessments", :force => true do |t|
    t.integer  "unit_id"
    t.string   "name"
    t.datetime "due_at"
    t.float    "total_marks"
    t.float    "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "at_risk_events", :force => true do |t|
    t.integer  "enrollment_id"
    t.datetime "viewed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", :force => true do |t|
    t.integer  "enrollment_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faculty_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "enrollment_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performances", :force => true do |t|
    t.integer  "enrollment_id"
    t.integer  "assessment_id"
    t.float    "achieved_mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "at_risk_event_id"
    t.string   "response"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "begins_at"
    t.datetime "ends_at"
    t.integer  "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "is_faculty"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",     :default => true
  end

end
