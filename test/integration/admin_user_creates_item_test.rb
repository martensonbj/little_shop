require "test_helper"

class AdminUserCreatesItemTest < ActionDispatch::IntegrationTest
  test "admin creates a item" do
    admin = create(:admin)
    artist = create(:artist)
    image_path = "https://petenelson.com/wp-content" \
                 "/uploads/2011/08/ron-swanson-meat.jpg"

    category1 = create_list(:category, 3).first
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "Create Item"
    assert_equal new_admin_item_path, current_path
    fill_in "Title", with: "Meat"
    fill_in "Image path", with: image_path
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select "#{category1.name}", from: "item_category_id"
    select "#{artist.first_name}", from: "item_user_id"
    click_on "Create Item"

    assert_equal item_path(Item.last), current_path
    assert_equal 1, Item.count
    assert page.has_content? "Meat"
    assert page.has_content? artist.full_name
  end

  test "item can have a price with commas and dollar signs" do
    admin = create(:admin)
    artist = create(:artist)
    image_path = "https://petenelson.com/wp-content" \
                 "/uploads/2011/08/ron-swanson-meat.jpg"

    category1 = create_list(:category, 3).first
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "Create Item"
    assert_equal new_admin_item_path, current_path
    fill_in "Title", with: "Meat"
    fill_in "Image path", with: image_path
    fill_in "Price", with: "$100,000"
    fill_in "Description", with: "Salad? That's what my food eats"
    select "#{category1.name}", from: "item_category_id"
    select "#{artist.first_name}", from: "item_user_id"
    click_on "Create Item"

    assert_equal item_path(Item.last), current_path
    assert_equal 1, Item.count
    assert page.has_content? Item.last.price
    assert_equal 100000, Item.last.price
  end
end
