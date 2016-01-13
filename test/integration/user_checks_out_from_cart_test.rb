require "test_helper"

class UserChecksOutFromCartTest < ActionDispatch::IntegrationTest
  test "user is asked to log in then order is placed" do
    # Background: An existing user and a cart with items
    user = create(:user)
    items = add_two_items_to_cart
    # As a visitor
    # When I visit "/cart"
    visit cart_path
    # And I click "Checkout"
    click_button "Checkout"
    # Then I should be required to login
    assert_equal login_path, current_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Login"
    # When I am logged in
    # And I visit "/cart"
    visit cart_path
    # And I click "Checkout"
    click_button "Checkout"
    # Then the order should be placed
    assert_equal 1, Order.count
    # And my current page should be "/orders"
    assert_equal orders_path, current_path
    # And I should see a message "Order was successfully placed"
    assert page.has_content?("Order was successfully placed")
    # And I should see the order I just placed in a table
    save_and_open_page
    # within "table" do
      assert page.has_content?("Total: $#{item.price}")
      assert page.has_content?("#{item.title}")
    # end
  end

  test "logged in user places order" do
    skip
  end
end
