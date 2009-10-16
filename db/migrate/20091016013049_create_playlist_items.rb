class CreatePlaylistItems < ActiveRecord::Migration
  def self.up
    create_table :playlist_items do |t|
      t.integer :item_id, :null => false 
      t.integer :playlist_id, :null => false 
      t.integer :item_type_id, :default => 1 
      t.integer :position, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :playlist_items
  end
end
