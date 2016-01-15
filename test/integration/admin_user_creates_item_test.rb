require "test_helper"

class AdminUserCreatesItemTest < ActionDispatch::IntegrationTest
  test "admin creates a item" do
    admin = User.create(first_name: "Admin",
                     last_name: "Admin",
                     username: "admin",
                     password: "password",
                     role: 2)
    user = User.create(first_name: "taylor",
                      last_name: "moore",
                      username: "taylor",
                      password: "moore",
                      role: 1)

    category1, category2, category3 =
            create_list(:category, 3)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "Create Item"
    assert_equal new_admin_item_path, current_path
    fill_in "Title", with: "Meat"
    fill_in "Image path", with: "https://petenelson.com/wp-content/uploads/2011/08/ron-swanson-meat.jpg"
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select "#{category1.name}", from: "item_category_id"
    select "#{user.first_name}", from: "item_user_id"
    click_on "Create Item"

    assert_equal item_path(Item.last), current_path
    assert page.has_content? "Meat"
    assert page.has_content? "taylor moore"
  end
end
# As an authenticated Admin:
# I can create an item.
#
# An item must have a title, description and price.
# An item must belong to at least one category.
# The title and description cannot be empty.
# The title must be unique for all items in the system.
# The price must be a valid decimal numeric value and greater than zero.
# The photo is optional. If not present, a stand-in photo is used.
