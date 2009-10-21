# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class SvcPlaylist
  def self.call(env)

    if env["PATH_INFO"] =~ /^\/test/
      # simple return test, only code path is to generate the playlist (static)
      [200, {"Content-Type" => "text/html"}, [sample_playlist(10)]]
      
    elsif env["PATH_INFO"] =~ /^\/data_val_test/
      # validate parameters 
      request = Rack::Request.new(env)
      params = request.params
      resp = {}
      resp[:one] =  params['param1'] == 1 ? 'yes' : 'no'
      resp[:two] =  params['param2'] == 2 ? 'yes' : 'no'
      [200, {"Content-Type" => "text/html"}, [sample_playlist(10)]]


      elsif env["PATH_INFO"] =~ /^\/get_from_db/
        # validate parameters 
        request = Rack::Request.new(env)
        params = request.params
        resp = {}
        resp[:one] =  params['param1'] == 1 ? 'yes' : 'no'
        resp[:two] =  params['param2'] == 2 ? 'yes' : 'no'
        
        p = Playlist.find rand(3000000) + 100000
        [200, {"Content-Type" => "text/html"}, [p.to_json]]


    elsif env["PATH_INFO"] =~ /^\/header/
      n = rand(100000000000)
      p = Playlist.new(:title => "playlist load " + n.to_s, :user_id => rand(10000), :description => "Created at " + Time.now.to_s)
      p.save
      [200, {"Content-Type" => "text/html"}, [p.id.to_s]]


    elsif env["PATH_INFO"] =~ /^\/make/
      return   [403, {"Content-Type" => "text/html"}, ['done']] unless authenticated?(env)
      # validate parameters 
      request = Rack::Request.new(env)
      params = request.params
      user_id =  rand(1000000)
      p = Playlist.new(:title => params['title'], :description => params['desc'], :user_id => user_id)
      p.save
      items = params['items'].to_i
      for i in 1..items
        p.playlist_items << PlaylistItem.new(:item_id => rand(100000000), :item_type_id => 1, :position => i, :user_id => user_id)
        p.save
      end
      [201, {"Content-Type" => "text/html"}, ['created']]


    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]


    end
  end
  ActiveRecord::Base.clear_active_connections!
end


def sample_playlist(num_playlist_items=5)
  # create a standard sample playlist with num_playlist_items items. 
  item = "{\"playlist_item\":{\"item_id\":77851204,\"updated_at\":\"2009-10-18T19:13:05Z\",\"playlist_id\":1119191,\"id\":5079817,\"user_id\":8,\"position\":1,\"item_type_id\":1,\"created_at\":\"2009-10-18T19:13:05Z\"}}"
    "{\"playlist\":{\"status\":true,\"flags\":0,\"updated_at\":\"2009-10-17T01:19:14Z\",\"favorite_count\":0,\"title\":\"playlist load 78661392779\",\"id\":100010,\"description\":\"Created at Fri Oct 16 18:19:14 -0700 2009\",\"user_id\":838,\"created_at\":\"2009-10-17T01:19:14Z\", \"random\":\"1\", \"playlist_items\":[#{item * num_playlist_items}]   }   }"

end

def authenticated?(env)
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
