class AddUserIDPlaylistItem < ActiveRecord::Migration
  def self.up
    add_column :playlist_item, :user_id, :integer
  end

  def self.down
    remove_column :playlist_item, :user_id
  end
end
