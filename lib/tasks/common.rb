def twitter_post                                      #call twitter_post.update("to update to twitter")
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['T2CK']
    config.consumer_secret     = ENV['T2CS']
    config.access_token        = ENV['T2AT']
    config.access_token_secret = ENV['T2ATS']
  end
end

def get_tinyurl(url)
   return open("http://tinyurl.com/api-create.php?url=#{url}").read
end
