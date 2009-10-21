class PlaylistItem < ActiveRecord::Base
  # set_table_name "playlist_item_part"
  belongs_to :playlist
end
