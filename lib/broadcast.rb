class Broadcast
  def self.process(notification)
    Broadcastworker.perform_async(source: notification.source, message: notification.message)
  end

end
