# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class SvcPlaylist
  def self.call(env)
  
    if env["PATH_INFO"] =~ /^\/test/
      # random = 1 # Time.now.to_f.to_s
      rtn = "{\"playlist\":{\"status\":true,\"flags\":0,\"updated_at\":\"2009-10-17T01:19:14Z\",\"favorite_count\":0,\"title\":\"playlist load 78661392779\",\"id\":100010,\"description\":\"Created at Fri Oct 16 18:19:14 -0700 2009\",\"user_id\":838,\"created_at\":\"2009-10-17T01:19:14Z\", \"random\":\"1\"}}"
      [200, {"Content-Type" => "text/html"}, [rtn]]
      
      
    elsif env["PATH_INFO"] =~ /^\/header/
      n = rand(100000000000)
      p = Playlist.new(:title => "playlist load " + n.to_s, :user_id => rand(10000), :description => "Created at " + Time.now.to_s)
      p.save
      [200, {"Content-Type" => "text/html"}, [p.id.to_s]]
      
      
    elsif env["PATH_INFO"] =~ /^\/make/
      return   [403, {"Content-Type" => "text/html"}, ['done']] unless authenticated?(env)
      n = rand(100000000000)
      p = Playlist.new(:title => "playlist load " + n.to_s, :user_id => rand(10000), :description => "Created at " + Time.now.to_s)
      p.save
      items = rand(5) + 3
      for i in 1..items
        p.playlist_items << PlaylistItem.new(:item_id => rand(100000000), :item_type_id => 1, :position => i)
        p.save
      end
      [200, {"Content-Type" => "text/html"}, ['done']]
      
      
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
      
      
    end
  end
  ActiveRecord::Base.clear_active_connections!
end
 

class None < Object
  # This is for cuttin' and pastin' only!
  def nada
    
    for n in 1..100000000000
      start = Time.now
      p = Playlist.new(:title => "playlist load " + n.to_s, :user_id => rand(10000), :description => "Created at " + Time.now.to_s)
      p.save
      puts "Save playlist took " + (Time.now - start).to_f.to_s + " sec."
      items = rand(5) + 3
      for i in 1..items
        
        p.playlist_items << PlaylistItem.new(:item_id => rand(100000000), :item_type_id => 1, :position => i)
        p.save
      end
      puts "Save a playlist with " + items.to_s + " items took " + (Time.now - start).to_f.to_s + " sec."
    end
  end
  def authenticated?(env)
    #stuff
    nil
  end 
end
