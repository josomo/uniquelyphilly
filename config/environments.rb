#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
#Heroku config
configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
 
  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )

  require 'dotenv'
  Dotenv.load
end 


configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database =>  'sinatra_application.sqlite3.db'
  )

  require 'dotenv'
  Dotenv.load
end