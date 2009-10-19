class PopulateUserIdInPlaylistItems < ActiveRecord::Migration
  def self.up
    execute "update playlist_production.playlist_items i set i.user_id = ( select p.user_id from playlist_production.playlists p where p.id = i.playlist_id)"
  end

  def self.down
    # this isn't really irreversible, but this is an example.
    raise ActiveRecord::IrreversibleMigration
  end
end
