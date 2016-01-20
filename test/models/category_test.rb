require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  test "category name cannot be duplicate" do
    Category.create(name: "Painting")
    Category.create(name: "Painting")

    assert_equal 1, Category.count
  end
end
