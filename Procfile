web: bundle exec rackup
redis: redis-server
worker: bundle exec sidekiq -e development -r ./lib/broadcast_worker.rb
