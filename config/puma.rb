# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path("../../../..", __FILE__)
shared_dir = "#{app_dir}/shared"

# Default to production
rack_env = ENV['RACK_ENV'] || "production"
environment rack_env

if rack_env == "production"
  # Set up socket location
  bind "unix://#{shared_dir}/sockets/puma.sock"

  # Logging
  stdout_redirect "log/puma.stdout.log", "log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{shared_dir}/pids/puma.pid"
  state_path "#{shared_dir}/pids/puma.state"
end
