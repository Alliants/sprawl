require "sidekiq"
require "faraday"

class BroadcastWorker
  include Sidekiq::Worker

  def perform(notification)
    source = notification.fetch("source")

    notification.fetch("subscribers").each do |subscriber|
      conn = Faraday.new(url: subscriber) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end

      response = conn.post "/notification", source: source, message: notification.fetch("message")

      logger.info "Notification from #{source} to #{subscriber} with status #{response.status}"
    end
  end
end
