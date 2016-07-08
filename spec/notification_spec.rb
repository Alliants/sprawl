require "spec_helper"

describe Notification do
  describe "==" do
    it "confirms 2 objects are the same" do
      notification1 = Notification.new(source: "1", message: "1")
      notification2 = Notification.new(source: "1", message: "1")

      expect(notification1).to eq notification2
    end

    it "confirms 2 objects are different" do
      notification1 = Notification.new(source: "1", message: "1")
      notification2 = Notification.new(source: "2", message: "1")

      expect(notification1).to_not eq notification2
    end
  end
end
