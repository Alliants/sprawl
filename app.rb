require "cuba"
require "cuba/safe"
require "./lib/broadcast_worker"
require "./lib/broadcast"
require "./lib/notification"

Cuba.use Rack::Session::Cookie, secret: "__a_very_long_string__"

Cuba.plugin Cuba::Safe

Cuba.define do
  on post do
    on "notification" do
      on param("payload") do |payload|
        notification = Notification.new(source: req.host, message: payload.fetch("message"))
        Broadcast.process(notification)
        res.write "message received"
      end

      on true do
        res.write "Please provide a payload"
      end
    end
  end
end
