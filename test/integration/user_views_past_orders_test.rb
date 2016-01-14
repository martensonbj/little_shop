require 'test_helper'

class UserViewsPastOrdersTest < ActionDispatch::IntegrationTest
  test "user sees all submitted orders" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    order1 = add_item_to_cart_and_visit_shopping_cart
    click_on "Checkout"
    order2 = add_item_to_cart_and_visit_shopping_cart
    click_on "Checkout"

    visit orders_path

    assert_equal 2, Order.all.count
  end
end
