class Playlist < ActiveRecord::Base
  set_table_name "playlist_part"
  has_many :playlist_items
end
