namespace :testdata do
  desc "create 40 million new playlists with between 5 and 50 items, or about 1bb paylist items "
  task (:create_playlists => :environment ) do 
    require 'populator'
    count = 0
    sTime = Time.now
    Playlist.populate(40_000_000) do |playlist|
        n = rand(10_000).to_s
        playlist.title = "mass populated " + n 
        playlist.description = "mass populated description " + n 
        playlist.user_id = 1..100_000
        playlist.flags  = 1..500
        playlist.favorite_count = 0..100
        playlist.status = [true, false]
        pos = 0
        PlaylistItem.populate(5..50) do |item|
          item.playlist.id = playlist.id 
          item.item_id = 10_000..1_000_000
          item.item_type = 1..5
          item.user_id = playlist.user_id 
          item.position = pos
          pos += 1 
        end 
        count += 1
    end
    puts "Created " + count.to_s " new playlists."
    puts "Elapsed: " + (sTime - Time.now).to_s
  end
end

    
    
  

