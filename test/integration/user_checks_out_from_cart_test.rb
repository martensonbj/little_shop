require "test_helper"

class UserChecksOutFromCartTest < ActionDispatch::IntegrationTest
  test "user is asked to log in then order is placed" do
    user = create(:user)
    items = add_two_items_to_cart

    visit cart_path
    click_button "Checkout"

    assert_equal login_path, current_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Login"

    visit cart_path
    click_button "Checkout"

    assert_equal 1, Order.count

    assert_equal orders_path, current_path

    assert page.has_content?("Order was successfully placed")
    assert page.has_content?(items.first.title)
    assert page.has_content?(items.last.title)
    assert page.has_content?(Order.last.id)
    assert page.has_content?(Order.last.total)
  end

  test "logged in user places order" do
    items = add_two_items_to_cart
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit cart_path
    click_button "Checkout"

    assert_equal 1, Order.count

    assert_equal orders_path, current_path

    assert page.has_content?("Order was successfully placed")
    assert page.has_content?(items.first.title)
    assert page.has_content?(items.last.title)
    assert page.has_content?(Order.last.id)
    assert page.has_content?(Order.last.total)
  end
end
