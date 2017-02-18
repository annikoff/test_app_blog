# frozen_string_literal: true
require 'factory_girl_rails'
require 'shoulda-matchers'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/bin/'
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
