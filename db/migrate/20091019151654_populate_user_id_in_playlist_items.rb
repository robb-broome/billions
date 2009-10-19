class PopulateUserIdInPlaylistItems < ActiveRecord::Migration
  def self.up
    execute "update playlist_items set user_id = ( select user_id from playlists  where id = playlist_id)"
  end

  def self.down
    execute "update playlist_items set user_id = null"
  end
end
