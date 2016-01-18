require "test_helper"

class UserCanViewPastOrdersTest < ActionDispatch::IntegrationTest
  test "user sees all submitted orders" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    add_items_to_cart_and_visit_shopping_cart(1)
    click_on "Checkout"
    add_items_to_cart_and_visit_shopping_cart(1)
    click_on "Checkout"

    visit user_orders_path(user.slug)

    assert_equal 2, Order.all.count
    assert page.has_content?(Order.first.id)
    assert page.has_content?(Order.first.total)
    assert page.has_content?(Order.last.id)
    assert page.has_content?(Order.last.total)
  end
end
