require "test_helper"

class AdminViewAIndividualOrderTest < ActionDispatch::IntegrationTest
  test "admin can view any single order" do
    admin = create(:admin)
    order = Order.find(create(:order_item).order_id)
    user = order.user
    item = order.items.first
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_order_path(order)

    assert page.has_content? user.first_name
    assert page.has_content? user.last_name
    assert page.has_content? user.email_address
    assert page.has_content? user.street_address
    assert page.has_content? user.city
    assert page.has_link? item.title, href: item_path(item)
    assert page.has_content? "Total: $#{item.price}"
    assert page.has_content? order.date
    assert page.has_content? "Subtotal: $#{item.price}"
    assert page.has_content? "Quantity: 1"
    assert page.has_content? order.status.capitalize
  end
end
