require 'simplecov'
require 'factory_bot'

SimpleCov.start do
  add_filter %r{(_spec\.rb)$}
  add_filter "factories.rb"
end
SimpleCov.minimum_coverage line: 100

(Dir.entries("./lib") - ['.', '..']).each do |file|
  require file
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end