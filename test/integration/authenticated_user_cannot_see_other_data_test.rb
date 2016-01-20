require "test_helper"

class AuthenticatedUserCannotSeeOtherDataTest < ActionDispatch::IntegrationTest
  test "an authenticated user cannot see admin or other users data" do
    user1 = create(:user)
    user2 = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(user1)
    add_items_to_cart_and_visit_shopping_cart(2)
    visit user_cart_path(user1)
    click_button "Checkout"

    ApplicationController.any_instance.stubs(:current_user).returns(user2)
    add_items_to_cart_and_visit_shopping_cart(2)
    visit user_cart_path(user2)
    click_button "Checkout"
    visit user_orders_path(user2)

    assert page.has_content?(Order.last.id)

    visit user_orders_path(user1)
    message_404 = "The page you were looking for doesn't exist (404)"
    assert page.has_content?(message_404)

    visit admin_dashboard_path
    message_404 = "The page you were looking for doesn't exist (404)"
    assert page.has_content?(message_404)
  end
end
