require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/woe'
require './models/twittertrend'
require './models/reddittrend'

require 'pry'
binding.pry

get '/' do  
end