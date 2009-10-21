# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class SvcPlaylist
  def self.call(env)

    if env["PATH_INFO"] =~ /^\/test/
      # pl_items = "[{\"playlist_item\":{\"item_id\":77851204,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079817,\"user_id\":8,\"position\":1,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}},{\"playlist_item\":{\"item_id\":35251566,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079819,\"user_id\":8,\"position\":2,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}},{\"playlist_item\":{\"item_id\":32263871,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079822,\"user_id\":8,\"position\":3,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}},{\"playlist_item\":{\"item_id\":15351566,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079825,\"user_id\":8,\"position\":4,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}},{\"playlist_item\":{\"item_id\":88942541,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079828,\"user_id\":8,\"position\":5,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}}]"
      # 
      # 
      # sample_playlist = "{\"playlist\":{\"status\":true,\"flags\":0,\"updated_at\":\"2009-10-17T01:19:14Z\",\"favorite_count\":0,\"title\":\"playlist load 78661392779\",\"id\":100010,\"description\":\"Created at Fri Oct 16 18:19:14 -0700 2009\", \"user_id\":838,\"created_at\":\"2009-10-17T01:19:14Z\", \"random\":\"1\", \"playlist_items\":{#{pl_items}}   }   }"
      [200, {"Content-Type" => "text/html"}, [sample_playlist]]

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


def sample_playlist
  pl_items = "[{\"playlist_item\":{\"item_id\":77851204,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079817,\"user_id\":8,\"position\":1,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}},{\"playlist_item\":{\"item_id\":35251566,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079819,\"user_id\":8,\"position\":2,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}},{\"playlist_item\":{\"item_id\":32263871,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079822,\"user_id\":8,\"position\":3,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}},{\"playlist_item\":{\"item_id\":15351566,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079825,\"user_id\":8,\"position\":4,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}},{\"playlist_item\":{\"item_id\":88942541,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079828,\"user_id\":8,\"position\":5,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}}]"


  "{\"playlist\":{\"status\":true,\"flags\":0,\"updated_at\":\"2009-10-17T01:19:14Z\",\"favorite_count\":0,\"title\":\"playlist load 78661392779\",\"id\":100010,\"description\":\"Created at Fri Oct 16 18:19:14 -0700 2009\",\"user_id\":838,\"created_at\":\"2009-10-17T01:19:14Z\", \"random\":\"1\", \"playlist_items\":#{pl_items}   }   }"


end

def authenticated?(env)
  #stuff
  true
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

end
