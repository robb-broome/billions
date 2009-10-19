class AddUserIdPlaylistItem < ActiveRecord::Migration
  def self.up
    add_column :playlist_items, :user_id, :integer
  end

  def self.down
    remove_column :playlist_items, :user_id
  end
end
