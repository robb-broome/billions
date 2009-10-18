# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class SvcPlaylist
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/playlist/
      p = Playlist.all().first
      [200, {"Content-Type" => "text/html"}, [p.to_json]]
    elsif env["PATH_INFO"] =~ /^\/test/
      [200, {"Content-Type" => "text/html"}, ['tested']]
    elsif env["PATH_INFO"] =~ /^\/header/
      n = rand(100000000000)
      p = Playlist.new(:title => "playlist load " + n.to_s, :user_id => rand(10000), :description => "Created at " + Time.now.to_s)
      p.save
      [200, {"Content-Type" => "text/html"}, [p.id.to_s]]
    elsif env["PATH_INFO"] =~ /^\/make/
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

100000, Average, 0.0232725698999999, TPS, 88.5661146045523
total time 2327.25698999999 average 0.0232725698999999
end at Sun Oct 18 07:39:07 -0700 2009


class None < Object
  # This is for cuttin' and pastin' only!
  def nada
    for n in 1..100000000000
      p = Playlist.new(:title => "playlist load " + n.to_s, :user_id => rand(10000), :description => "Created at " + Time.now.to_s)
      p.save
      items = rand(5) + 3
      for i in 1..items
        p.playlist_items << PlaylistItem.new(:item_id => rand(100000000), :item_type_id => 1, :position => i)
        p.save
      end
    end
  end
end
