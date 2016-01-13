ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "capybara/rails"
require "database_cleaner"
require "mocha/mini_test"

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  fixtures :all
  include FactoryGirl::Syntax::Methods
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
    reset_session!
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
    reset_session!
  end
end
