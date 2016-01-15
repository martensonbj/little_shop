require "test_helper"

class ItemTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:image_path)
  should validate_presence_of(:user_id)
  should validate_presence_of(:category_id)
  should validate_presence_of(:price)
  should validate_presence_of(:description)

  test "item can belong to an artist" do
    artist = create(:artist)
    category = create(:category)
    artist.items.create(title: "Title",
                        description: "Description",
                        price: 10,
                        category_id: category.id,
                        image_path: "http://example.jpg")

    assert_equal 1, artist.items.count
  end

  test "item cannot belong to a regular user" do
    user = create(:user)
    category = create(:category)
    user.items.create(title: "Title",
                      description: "Description",
                      price: 10,
                      category_id: category.id,
                      image_path: "http://example.jpg")

    assert_equal 0, user.items.count
  end

  test "item cannot belong to an admin" do
    admin = create(:admin)
    category = create(:category)
    admin.items.create(title: "Title",
                      description: "Description",
                      price: 10,
                      category_id: category.id,
                      image_path: "http://example.jpg")

    assert_equal 0, admin.items.count
  end
end
