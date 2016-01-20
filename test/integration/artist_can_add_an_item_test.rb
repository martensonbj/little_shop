require "test_helper"

class ArtistCanAddAnItemTest < ActionDispatch::IntegrationTest
  test "artist adds an item for themselves" do
    artist = create(:artist)
    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(artist)

    image_path = "https://petenelson.com/wp-content" \
                 "/uploads/2011/08/ron-swanson-meat.jpg"

    visit dashboard_path
    click_on "Add New Item"

    assert_equal new_user_item_path(artist), current_path

    fill_in "Title", with: "Meat"
    fill_in "Image path", with: image_path
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select category.name, from: "item_category_id"
    click_on "Create Item"

    item = Item.last

    assert_equal artist, item.user
    assert_equal item_path(item), current_path
    assert page.has_content? item.title
    assert page.has_content? item.user.full_name
  end

  test "user cannot add an item" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit new_user_item_path(user)

    message_404 = "The page you were looking for doesn't exist (404)"
    assert page.has_content? message_404
  end

  test "item can have a price with commas and dollar signs" do
    artist = create(:artist)
    image_path = "https://petenelson.com/wp-content" \
                 "/uploads/2011/08/ron-swanson-meat.jpg"

    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(artist)

    visit dashboard_path
    click_on "Add New Item"
    assert_equal new_user_item_path(artist), current_path

    fill_in "Title", with: "Meat"
    fill_in "Image path", with: image_path
    fill_in "Price", with: "$100,000"
    fill_in "Description", with: "Salad? That's what my food eats"
    select category.name, from: "item_category_id"
    click_on "Create Item"

    assert_equal item_path(Item.last), current_path
    assert_equal 1, Item.count
    assert page.has_content? Item.last.price
    assert_equal artist, Item.last.user
    assert_equal 100000, Item.last.price
  end

  test "artist cannot add item with missing fields" do
    artist = create(:artist)
    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(artist)

    image_path = "https://petenelson.com/wp-content" \
                 "/uploads/2011/08/ron-swanson-meat.jpg"

    visit dashboard_path
    click_on "Add New Item"

    assert_equal new_user_item_path(artist), current_path

    fill_in "Image path", with: image_path
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select category.name, from: "item_category_id"
    click_on "Create Item"

    assert page.has_content? "Incomplete form"
    assert_equal 0, Item.count
  end
end
