require "test_helper"

class AdminViewsAllOrdersTest < ActionDispatch::IntegrationTest
  test "admin can view any order orders" do
    admin = create(:admin)
    order_items = create_list(:order_item, 4)
    order1, order2, order3, order4 = order_items.map(&:order)
    order1.ordered!
    order2.paid!
    order3.cancelled!
    order4.completed!

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "View Orders"

    assert_equal admin_orders_path, current_path

    within "#totals" do
      assert page.has_content? "Ordered: 1"
      assert page.has_content? "Paid: 1"
      assert page.has_content? "Cancelled: 1"
      assert page.has_content? "Completed: 1"
    end

    assert page.has_link? order1.id, href: user_order_path(order1.user, order1)
    assert page.has_link? order2.id, href: user_order_path(order2.user, order2)
    assert page.has_link? order3.id, href: user_order_path(order3.user, order3)
    assert page.has_link? order4.id, href: user_order_path(order4.user, order4)

    click_link "Mark as Paid"
    assert_equal admin_orders_path, current_path
    within "#order_#{order1.id}" do
      assert page.has_content? "paid"
    end

    within "#order_#{order2.id}" do
      click_link "Cancel"
    end
    assert_equal admin_orders_path, current_path
    within "#order_#{order2.id}" do
      assert page.has_content? "cancelled"
    end
  end
end
