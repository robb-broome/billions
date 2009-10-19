namespace :testdata do
  desc "create lots of new playlists"
  task (:create_playlists => :environment ) do 
    require 'populator'
    Playlist.populate(1000000000) do |playlist|
        n = rand(10000).to_s
        playlist.title = "mass populated " + n 
        playlist.description = "mass populated description " + n 
        playlist.user_id = 1..100000
        playlist.flags  = 1..500
        playlist.favorite_count = 0..100
        playlist.status = [true, false]
        pos = 0
        PlaylistItem.populate(5..50) do |item|
          item.playlist.id = playlist.id 
          item.item_id = 10000..100000
          item.item_type = 1..5
          item.user_id = playlist.user_id 
          item.position = pos
          pos += 1 
        end 
    end
  end
end

    
    
  

