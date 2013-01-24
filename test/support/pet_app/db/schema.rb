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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121215205715) do

  create_table "animals", :force => true do |t|
    t.integer  "species_id"
    t.string   "name"
    t.integer  "owner_id"
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "animals", ["owner_id"], :name => "index_animals_on_owner_id"
  add_index "animals", ["species_id"], :name => "index_animals_on_species_id"

  create_table "owners", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "species", :force => true do |t|
    t.string   "name"
    t.integer  "legs"
    t.boolean  "tail"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end