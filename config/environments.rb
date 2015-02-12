#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path

configure :production do

  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://uniquelyphilly@localhost/uniquelyphilly')

  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host => db.host,
    :username => db.user,
    :password => ENV['PG_PW'],
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )

end 