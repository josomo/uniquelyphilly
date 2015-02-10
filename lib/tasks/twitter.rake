require 'twitter'

task :twittergrab_philly do 
  twitter_trend_grab("Philadelphia")
end

task :twittergrab_us do 
  twitter_trend_grab("United States")
end

task :twittergrab_world do 
  twitter_trend_grab("World")
end

task :push_uniques do
  latest_world = latest_trends("World")
  latest_us = latest_trends("United States")
  latest_philly = latest_trends("Philadelphia")
  [latest_philly - latest_world - latest_us].each { |t| twitter_post.client.update("#{t} is trending on Twitter"); sleep 5 }
end

def twitter_auth
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "M6lZ3IuZ6GqZDEKHKzEb7aUs7"
    config.consumer_secret     = "lyS56UzZDXxv842x6jGgFsNqQZ5OBDOoHgRQZORAmt8dEVVv82"
    config.access_token        = "2792619245-pxcje7PfDsisAuhMQh1vMfHDVHJ5dSPVPkVZxDg"
    config.access_token_secret = "6vDYSJrTZA1sGLoHb0JHbU0wh7EnBgSC1NixqVcK9Mck4"
  end
end

def twitter_post
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ""
    config.consumer_secret     = ""
    config.access_token        = ""
    config.access_token_secret = ""
  end
end

def twitter_trend_grab(place)
  location = Woe.find_by(name: place)
  twitter_auth.trends(location.id).each { |t| location.twittertrends.create(name: t.name) }
end

def latest_trends(place)
  Twittertrend.where(created_at: 2.minutes.ago..Time.now.utc, woe_id: Woe.find_by(name: place)).map {|t| t.name}
end
