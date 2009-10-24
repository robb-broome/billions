namespace :mass do

  desc "create 40 million new playlists with between 5 and 50 items, or about 1bb paylist items "
  task (:playlists => :environment ) do
    require 'populator'
    mk_playlists(:playlist_count => 40_000_000, :per_query => 1000, :items_per => (5..50))
  end

  desc "Mass populate, rest, do some ab testing, run database mysql-report script, repeat"
  task(:db_scale_test => :environment) do
    require 'populator'
    logger = set_log("db_scale_test_#{Time.now.to_f.to_s}.txt")
    100.times do
      logger.write mk_playlists(:playlist_count => 1000, :per_query => 100, :items_per => (5..50))
      db_stats(logger)
      ab_test(logger)

      # restart mysql (needed after the flush? )
      # ssh eccdb  "monit restart mysql"
      # sleep 60
    end
    logger.close

  end

  # supporting methods
  def mk_playlists(playlist_count=40_000_000, per_query=1000, items_per=5..50 )
    # make a whole playlist with items, or, if you say items_per = 0, just headers.
    sTime = Time.now
    playlist_count = item_count = 0
    Playlist.populate(playlist_count, :per_query => per_query) do |playlist|
      n = rand(10_000).to_s
      playlist.title = "mass populated " + Populator.words(2)
      playlist.description = Populator.words(10..15)
      playlist.user_id = 1..100_000
      playlist.flags  = 1..500
      playlist.favorite_count = 0..100
      playlist.status = [true, false]

      item_count += mk_playlist_items(:playlist => playlist, :items_per => items_per )
      playlist_count += 1
    end
    return "#{Time.now.to_s}  Elapsed: #{(sTime - Time.now).to_s} Playlists: {playlist_count} Items: #{item_count}"
  end

  def set_log(name)
    log_path = ""
    File.new("#{log_path}#{name}", "w")
  end

  def mk_playlist_items(playlist, items_per=5..50)
    pos = 0
    PlaylistItem.populate(items_per) do |item|
      item.playlist_id = playlist.id
      item.item_id = 10_000..1_000_000
      item.item_type_id = 1..5
      item.position = pos
      pos += 1
    end
    return pos
  end

  def ab_test(file)
    # reasonable
    p_url = "http://ec2-75-101-187-193.compute-1.amazonaws.com"
    p_action = "header"
    file.write ab(:n => 10000, :c => 100, :url => p_url, :action => p_action  )
  end

  def ab(n, c, url, action)
    `ab -n #{n} -c #{c} #{url}/#{action}`
  end

  def db_stats(file)
    file.write `mysqlreport --host db_primary --port 3306 --user playlist --password test1234 --flush-status`
  end


end
