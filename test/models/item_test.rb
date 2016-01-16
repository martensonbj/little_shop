require "test_helper"

class ItemTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
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

  test "item cannot have the same title as another item" do
    artist = create(:artist)
    category = create(:category)
    artist.items.create(title: "Title",
                        description: "Description",
                        price: 10,
                        category_id: category.id,
                        image_path: "http://example.jpg")

    assert_equal 1, artist.items.count

    artist.items.create(title: "Title",
                        description: "Description Two",
                        price: 20,
                        category_id: category.id,
                        image_path: "http://example2.jpg")

    assert_equal 1, artist.items.count
  end

  test "item price cannot be negative" do
    artist = create(:artist)
    category = create(:category)
    artist.items.create(title: "Title",
                        description: "Description",
                        price: -100,
                        category_id: category.id,
                        image_path: "http://example.jpg")

    assert_equal 0, artist.items.count
  end

  test "item price cannot be zero" do
    artist = create(:artist)
    category = create(:category)
    artist.items.create(title: "Title",
                        description: "Description",
                        price: 0,
                        category_id: category.id,
                        image_path: "http://example.jpg")

    assert_equal 0, artist.items.count
  end

  test "item price cannot be a set of characters" do
    artist = create(:artist)
    category = create(:category)
    artist.items.create(title: "Title",
                        description: "Description",
                        price: "abc",
                        category_id: category.id,
                        image_path: "http://example.jpg")

    assert_equal 0, artist.items.count
  end

  test "item image is optional and a default is assigned if it is blank" do
    artist = create(:artist)
    category = create(:category)
    artist.items.create(title: "Title",
                        description: "Description",
                        price: 10,
                        category_id: category.id)

    photo_not_available = "https://www.weefmgrenada.com/images/na4.jpg"

    assert_equal 1, artist.items.count
    assert_equal photo_not_available, artist.items.last.image_path
  end
end
