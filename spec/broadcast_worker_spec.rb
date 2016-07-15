require "spec_helper"

describe BroadcastWorker do
  describe "#perform" do
    it "notifies each subcriber" do
      request_stub = stub_request(:post, "http://example.com/notification")

      subject.perform("source" => "http://some.source",
                      "message" => "Foo",
                      "subscribers" => ["http://example.com"])

      expect(request_stub).to have_been_requested
    end
  end
end
