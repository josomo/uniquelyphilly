require 'open-uri'
require_relative '../philly_word_bank.rb'
require_relative './common.rb'

task :reddit do
  hot = JSON.parse(open('http://www.reddit.com/.json').read)
  top = JSON.parse(open('http://www.reddit.com/top/.json').read)
  store_trends(hot, "hot")
  store_trends(top, "top")
  post_latest(latest_relevant_posts)
end

def store_trends(page_collection, page_type)
    page_collection["data"]["children"].each do |child|
      title = child["data"]["title"]
      link = child["data"]["permalink"]
      title_arr = title.downcase.gsub(/[^a-z0-9\s]/i, '').split(' ')
      philly_link = false
      if (title_arr-word_bank).length != title_arr.length
        philly_link = true
        tinyurl = get_tinyurl(link)
        Reddittrend.create(title: title, link: link, tinyurl: tinyurl, page: page_type, philly_link: philly_link)
      else
        Reddittrend.create(title: title, link: link, page: page_type, philly_link: philly_link)
      end
    end
end

def latest_relevant_posts
  posts={}
  Reddittrend.where(philly_link: true, created_at: 3.minutes.ago..Time.now.utc).each do |t|
    posts[t.tinyurl] = t.page
  end
  return posts
end

def not_repeating(collection)
end

def post_latest(collection)
  collection.each do |k, v| 
    if v == "hot"
      twitter_post.update("#Philly is mentioned on @reddit's frontpage: #{k}")
    elsif v == "top"
      twitter_post.update("#Philly is mentioned in a hot @reddit post: #{k} ")
    end
  end
end