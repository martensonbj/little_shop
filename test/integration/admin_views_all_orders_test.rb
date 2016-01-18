require "test_helper"

class AdminViewsAllOrdersTest < ActionDispatch::IntegrationTest
  test "admin can view any order orders" do
    # admin = create(:admin)
    # order = Order.find(create(:order_item).order_id)
    # user = order.user
    # item = order.items.first
    # ApplicationController.any_instance.stubs(:current_user).returns(admin)
    #
    # visit admin_dashboard_path
    # click_on "View Orders"
    # assert_equal admin_orders_path, current_path
    # find("#order_#{Order.last.id}").click

    # visit admin_order_path(Order.last)

    # assert page.has_content? user.first_name
    # assert page.has_content? user.last_name
    # assert page.has_content? user.email_address
    # assert page.has_content? user.street_address
    # assert page.has_content? user.city
    # assert page.has_link? item.title, href: item_path(item)
  end
end
