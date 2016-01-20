require "test_helper"

class AdminUserCreatesItemTest < ActionDispatch::IntegrationTest
  test "admin creates a item" do
    admin = create(:admin)
    artist = create(:artist)
    image_path = "https://petenelson.com/wp-content" \
                 "/uploads/2011/08/ron-swanson-meat.jpg"

    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "Create Item"

    assert_equal new_admin_item_path, current_path

    fill_in "Title", with: "Meat"
    fill_in "Image path", with: image_path
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select category.name, from: "item_category_id"
    select artist.first_name, from: "item_user_id"
    click_on "Create Item"

    item = Item.last

    assert_equal item_path(item), current_path
    assert_equal 1, Item.count
    assert page.has_content? "Meat"
    assert page.has_content? artist.full_name
  end

  test "item can have a price with commas and dollar signs" do
    admin = create(:admin)
    artist = create(:artist)
    image_path = "https://petenelson.com/wp-content" \
                 "/uploads/2011/08/ron-swanson-meat.jpg"

    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "Create Item"

    assert_equal new_admin_item_path, current_path

    fill_in "Title", with: "Meat"
    fill_in "Image path", with: image_path
    fill_in "Price", with: "$100,000"
    fill_in "Description", with: "Salad? That's what my food eats"
    select category.name, from: "item_category_id"
    select artist.first_name, from: "item_user_id"
    click_on "Create Item"

    item = Item.last

    assert_equal item_path(item), current_path
    assert_equal 1, Item.count
    assert page.has_content? item.price
    assert_equal 100000, item.price
  end

  test "item will not be created with missing fields" do
    admin = create(:admin)
    artist = create(:artist)
    image_path = "https://petenelson.com/wp-content" \
                 "/uploads/2011/08/ron-swanson-meat.jpg"

    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "Create Item"

    assert_equal new_admin_item_path, current_path

    fill_in "Title", with: "Meat"
    fill_in "Image path", with: image_path
    fill_in "Description", with: "Salad? That's what my food eats"
    select category.name, from: "item_category_id"
    select artist.first_name, from: "item_user_id"
    click_on "Create Item"

    assert page.has_content? "Incomplete form"
    assert_equal 0, Item.count
  end
end
