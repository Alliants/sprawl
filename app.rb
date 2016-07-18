$LOAD_PATH.unshift File.dirname(__FILE__)

require "cuba"
require "cuba/safe"

require "lib/broadcast"
require "lib/notification"

Cuba.use Rack::Session::Cookie, secret: "__a_very_long_string__"

Cuba.plugin Cuba::Safe

Cuba.define do
  on get do
    on "health" do
      res.write({status: "ok"}.to_json)
    end
  end

  on post do
    on "notification" do
      on param("payload") do |payload|
        notification = Notification.new(source: req.host, message: payload)
        Broadcast.process(notification)
        res.write "message received"
      end

      on true do
        res.write "Please provide a payload"
      end
    end
  end
end
