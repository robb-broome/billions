namespace :testdata do
  desc "create lots of new playlists"
  task (:create_playlists => :environment ) do 
    require 'populator'
    Playlist.populate(1000) do |playlist|
        n = rand(10000).to_s
        playlist.title = "mass populated " + n 
        playlist.description = "mass populated description " + n 
        playlist.user_id = 1..100000
    end
  end
end

    
    
  

