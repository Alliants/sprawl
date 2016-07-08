class Notification
  attr_reader :source, :message

  def initialize(source:, message:)
    @source = source
    @message = message
  end

  def ==(other)
    source == other.source && message == other.message
  end
end
