# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091019151654) do

  create_table "playlist_items", :force => true do |t|
    t.integer  "item_id",                     :null => false
    t.integer  "playlist_id",                 :null => false
    t.integer  "item_type_id", :default => 1
    t.integer  "position",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "playlist_items", ["playlist_id"], :name => "index_playlist_items_on_playlist_id"
  add_index "playlist_items", ["user_id"], :name => "index_playlist_items_on_user_id"

  create_table "playlists", :force => true do |t|
    t.string   "title",          :limit => 80,                    :null => false
    t.string   "description",    :limit => 250
    t.integer  "user_id",                                         :null => false
    t.integer  "favorite_count",                :default => 0
    t.integer  "flags",                         :default => 0
    t.boolean  "status",                        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
