ENV["RAILS_ENV"] ||= "test"
require "simplecov"
SimpleCov.start "rails"
puts "required simplecov"
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

  def add_item_to_cart
    item = create(:item)
    visit item_path(item)

    click_button "Add to Cart"

    find("#shopping_cart").click
    item
  end
end
