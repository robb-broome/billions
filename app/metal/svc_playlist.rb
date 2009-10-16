# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class SvcPlaylist
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/playlist/
      p = Playlist.all().first
      [200, {"Content-Type" => "text/htmlG"}, [p.to_json]]
    elsif env["PATH_INFO"] =~ /^\/make/
        n = rand(100000000000)
        p = Playlist.new(:title => "playlist load " + n.to_s, :user_id => rand(10000), :description => "Created at " + Time.now.to_s)
        items = rand(20) + 3
        for i in 1..items
          p.playlist_items << PlaylistItem.new(:item_id => rand(100000000), :item_type_id => 1, :position => i)
        end 
        p.save
        [200, {"Content-Type" => "text/html"}, [p.to_json]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
