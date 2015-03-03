require 'twitter'
require_relative './common.rb'

task :twitter do
  twitter_trend_grab("Philadelphia"); sleep 5
  twitter_trend_grab("United States"); sleep 5
  twitter_trend_grab("World"); sleep 5
  twitter_push
end

def twitter_push
  latest_philly = latest_trends("Philadelphia")
  recent_philly = recent_trends("Philadelphia")
  latest_world = latest_trends("World")
  latest_us = latest_trends("United States")
  uniques = (latest_philly - recent_philly - latest_world - latest_us)
  uniques.each { |t| twitter_post.update("#{t} is trending on Twitter in #philly"); sleep 10 }
end

def twitter_auth
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['T1CK']
    config.consumer_secret     = ENV['T1CS']
    config.access_token        = ENV['T1AT']
    config.access_token_secret = ENV['T1ATS']
  end
end

def twitter_trend_grab(place)
  location = Woe.find_by(name: place)
  twitter_auth.trends(location.id).each { |t| location.twittertrends.create(name: t.name) }
end

def latest_trends(place)
  Twittertrend.where(created_at: 3.minutes.ago..Time.now.utc, woe_id: Woe.find_by(name: place)).map {|t| t.name}
end

def recent_trends(place)
  Twittertrend.where(created_at: 120.minutes.ago..Time.now.utc, woe_id: Woe.find_by(name: place)).map {|t| t.name}
end