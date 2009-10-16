# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class SvcPlaylist
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/playlist/
      p = Playlist.all().first
      [200, {"Content-Type" => "application/json"}, [p.to_json]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
