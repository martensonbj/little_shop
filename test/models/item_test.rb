require "test_helper"

class ItemTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:image_path)
  should validate_presence_of(:user_id)
  should validate_presence_of(:category_id)
  should validate_presence_of(:price)
  should validate_presence_of(:description)
end
