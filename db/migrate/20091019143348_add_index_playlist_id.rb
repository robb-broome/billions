class AddIndexPlaylistId < ActiveRecord::Migration
  def self.up
    add_index :playlist_items, :playlist_id
  end

  def self.down
    remove_index :playlist_items, :playlist_id
  end
end
