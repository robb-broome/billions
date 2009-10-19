# try number one. Lame. See the mass_populate rake task. 
require 'active_record'
require 'populator'
include Playlist
include PlaylistItem


# say 'production' for the arg
database_type = ARGV[0]

database_yaml = IO.read('../../config/database.yml')

class Mass  
  def self.run
    Playlist.populate(1000) do |playlist|
        n = rand(10000).to_s
        playlist.title = "mass populated " + n 
        playlist.description = "mass populated description " + n 
        playlist.user_id = 1..100000
    end 
  end
end

databases = YAML::load(database_yaml)
ActiveRecord::Base.establish_connection(databases[database_type])
Mass.run