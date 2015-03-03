set :output, "/home/deployer/uniquelyphilly.com/log/cron_log.log"

every 5.minutes do
  rake 'twitter'
end