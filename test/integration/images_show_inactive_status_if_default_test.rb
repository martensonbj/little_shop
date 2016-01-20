require "test_helper"

class ImagesShowInactiveStatusIfDefaultTest < ActionDispatch::IntegrationTest
  test "images default to inactive if there is no image" do
    artist = create(:artist)
    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(artist)

    visit dashboard_path
    click_on "Add New Item"

    assert_equal new_user_item_path(artist), current_path

    fill_in "Title", with: "Meat"
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select category.name, from: "item_category_id"
    click_on "Create Item"
    item = Item.last

    assert_equal artist, item.user
    assert_equal "https://www.weefmgrenada.com/images/na4.jpg", item.image_path
    assert_equal item_path(item), current_path
    assert_equal "inactive", item.status

    visit edit_user_item_path(artist, item)
    choose "Active"
    click_on "Update Item"

    assert_equal item_path(item), current_path
    assert page.has_content? "Please upload an image to change status."
    assert_equal "inactive", item.status
  end
end
