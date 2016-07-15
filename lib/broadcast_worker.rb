class BroadcastWorker
  include Sidekiq::Worker

  def perform(source:, message:)
  end
end
