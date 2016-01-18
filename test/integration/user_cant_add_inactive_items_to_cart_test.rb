require "test_helper"

class UserCantAddInactiveItemsToCartTest < ActionDispatch::IntegrationTest
  test "user can view inactive item but cannot add to cart" do
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    item = create(:item)
    visit admin_items_path
    click_on "Edit"
    choose "Inactive"
    click_on "Update Item"

    assert_equal admin_item_path(Item.last), current_path
    assert page.has_content? "Status: inactive"
    assert page.has_content? "Edit"
    refute page.has_content? "Add to Cart"
    assert page.has_content? "This item is currently out of stock."

    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit items_path
    refute page.has_content? "Add to Cart"
    refute page.has_content? "Edit"
    assert page.has_content? "This item is currently out of stock."

    click_on item.title
    refute page.has_content? "Add to Cart"
    assert page.has_content? "This item is currently out of stock."
  end
end
