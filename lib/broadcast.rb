require "lib/broadcast_worker"

class Broadcast
  def self.process(notification)
    BroadcastWorker.perform_async(
      source: notification.source,
      message: notification.message,
      subscribers: subscribers
    )
  end

  def self.subscribers
    YAML.load_file(File.join(__dir__, "..", "config", "subscribers.#{ENV['RACK_ENV']}.yml"))
  end
end
