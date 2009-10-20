class AddUserIdPlaylistItem < ActiveRecord::Migration
  def self.up
    add_column :playlist_items, :user_id, :integer
    # this makes sure that subsequent migrations see this table. 
    PlaylistItem.reset_column_information
  end

  def self.down
    # example of irreversible migration
    ActiveRecord::IrreversibleMigration
    # remove_column :playlist_items, :user_id
  end
end
