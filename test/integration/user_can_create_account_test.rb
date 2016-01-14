require "test_helper"

class UserCanCreateAccountTest < ActionDispatch::IntegrationTest
  test "user can create account and sees profile" do
    add_items_to_cart_and_visit_shopping_cart(1)
    @item = @items.first
    assert page.has_content?(@item.title)

    visit "/"
    assert page.has_content?("Login")

    click_link_or_button "Create Account"
    assert_equal new_user_path, current_path

    fill_in "First name", with: "Brenna"
    fill_in "Last name", with: "Martenson"
    fill_in "Username", with: "brenna"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"
    user = User.last
    assert_equal "/dashboard", current_path
    within(".nav-wrapper") do
      assert page.has_content?("Logged in as #{user.first_name}")
    end
    refute page.has_content?("Login")
    assert page.has_content?("Logout")

    find("#shopping_cart").click
    assert_equal cart_path, current_path
    assert page.has_content?(@item.title)
    within "#nav-mobile" do
      click_on "Logout"
    end
    refute page.has_content?("Logout")
    assert page.has_content?("Login")
    refute page.has_content?("Logged in as")
  end
end
