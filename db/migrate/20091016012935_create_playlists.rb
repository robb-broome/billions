class CreatePlaylists < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.string :title, :null => false, :limit => 80
      t.string :description, :null => true, :limit => 250
      t.integer :user_id, :null => false 
      t.integer :favorite_count, :default => 0
      t.integer :flags, :default => 0
      t.boolean :status, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :playlists
  end
end
