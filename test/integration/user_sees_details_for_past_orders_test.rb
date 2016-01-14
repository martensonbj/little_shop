require "test_helper"

class UserSeesDetailsForPastOrdersTest < ActionDispatch::IntegrationTest
  test "user sees item order details and order status" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    add_two_items_to_cart_and_visit_shopping_cart
    click_on "Checkout"

    visit orders_path
    order = Order.first

    assert page.has_content?(order.id)
    assert page.has_content?(order.total)
    assert page.has_link?("Order ID: #{order.id}", href: order_path(order))
    click_on "Order ID: #{order.id}"

    @items.each do |item|
      assert page.has_content?(item.title)
      assert page.has_content?("Quantity: 1")
      assert page.has_content?("Subtotal: #{item.price * 1}")
      assert page.has_link?("#{item.title}", href: item_path(item))
    end

    assert page.has_content?("Status: Ordered")
    assert page.has_content?("Total: #{order.total}")
    assert page.has_content?("Ordered: #{order.date}")
  end
end
