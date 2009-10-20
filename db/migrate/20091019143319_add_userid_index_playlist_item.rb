class AddUseridIndexPlaylistItem < ActiveRecord::Migration
  def self.up
    # example of adding a prompt with time... 
    say_with_time "Adding user_id index to playlist items..." do
      add_index :playlist_items, :user_id
    end
  end

  def self.down
    remove_index :playlist_items, :user_id
  end
end
