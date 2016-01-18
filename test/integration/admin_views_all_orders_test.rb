require 'test_helper'

class AdminViewsAllOrdersTest < ActionDispatch::IntegrationTest
  test "admin can view any order orders" do
    admin = create(:admin)
    order = Order.find(create(:order_item).order_id)
    user = order.user
    item = order.items.first
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "View Orders"
    assert_equal admin_orders_path, current_path
    find("#order_#{Order.last.id}").click

    visit admin_order_path(Order.last)

    assert page.has_content? user.first_name
    assert page.has_content? user.last_name
    assert page.has_content? user.email_address
    assert page.has_content? user.street_address
    assert page.has_content? user.city
    assert page.has_link? item.title, href: item_path(item)


  end
end
# As an authenticated Admin, when I visit an individual order page
# Then I can see the order's date and time.
# And I can see the purchaser's full name and address.
# And I can see, for each item on the order:
#     - The item's name, which is linked to the item page.
#     - Quantity in this order.
#     - Price
#     - Line item subtotal.
# And I can see the total for the order.
# And I can see the status for the order.
