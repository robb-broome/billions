class AddUseridIndexPlaylistItem < ActiveRecord::Migration
  def self.up
    add_index :playlist_items, :user_id:
  end

  def self.down
    remove_index :playlist_items, :user_id:
  end
end
