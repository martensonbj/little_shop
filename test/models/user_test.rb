require "test_helper"

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email_address)
  should validate_uniqueness_of(:email_address)
  should validate_presence_of(:street_address)
  should validate_presence_of(:city)
  should validate_presence_of(:state)
  should validate_presence_of(:zipcode)
end
