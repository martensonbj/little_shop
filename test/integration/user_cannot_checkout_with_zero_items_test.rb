require "test_helper"

class UserCannotCheckoutWithZeroItemsTest < ActionDispatch::IntegrationTest
  test "no order is placed and message is displayed" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit cart_path
    click_on "Checkout"

    assert_equal 0, Order.count
    assert page.has_content?("Cannot place an order with no items")
  end
end
