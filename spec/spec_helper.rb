Bundler.require(:default, :development, :test)
require "./app"

module RSpecMixin
  include Rack::Test::Methods
  def app
    Cuba
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
