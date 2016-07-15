require "spec_helper"

describe BroadcastWorker do
  describe ".perform" do
    it "creates a job to be processed asynchronously" do
      notification = double("notification", source: "source string", message: "message string")
      expect(BroadcastWorker).to receive(:perform_async).with(source: notification.source, message: notification.message)
      Broadcast.process(notification)
    end
  end
end
