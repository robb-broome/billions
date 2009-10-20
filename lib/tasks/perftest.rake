namespace :performance do 
  desc "update the user_id col on playlist items in batches of 1000"
  sTime = Time.now
  puts "starting at " + sTime.to_s
  task (:update_user_id => :environment ) do
    Playlist.find_each(:batch_size => 1000 ) do  |playlist| 
        playlist.playlist_items.each {|item| item.user_id = playlist.user_id}
    end
    puts "Done"
    puts "Duration " + (Time.now - sTime).to_s
  end
end 