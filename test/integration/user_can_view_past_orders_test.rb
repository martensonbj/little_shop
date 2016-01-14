require "test_helper"

class UserCanViewPastOrdersTest < ActionDispatch::IntegrationTest
  test "user sees all submitted orders" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    add_item_to_cart_and_visit_shopping_cart(num = 1)
    click_on "Checkout"
    add_item_to_cart_and_visit_shopping_cart(num = 1)
    click_on "Checkout"

    visit orders_path

    assert_equal 2, Order.all.count
    assert page.has_content?(Order.first.id)
    assert page.has_content?(Order.first.total)
    assert page.has_content?(Order.last.id)
    assert page.has_content?(Order.last.total)
  end
end
