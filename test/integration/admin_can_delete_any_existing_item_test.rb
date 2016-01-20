require "test_helper"

class AdminCanDeleteAnyExistingItemTest < ActionDispatch::IntegrationTest
  test "admin deletes an item from the admin items index page" do
    admin = create(:admin)
    item = create(:item)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_items_path
    click_on "Delete"

    assert_equal admin_items_path, current_path
    refute page.has_content? item.title
  end

  test "admin can delete an item from any artist" do
    admin = create(:admin)
    item1 = create(:item)
    item2 = create(:item)

    refute_equal item1.user, item2.user
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_item_path(item1)
    click_on "Delete"

    assert_equal admin_items_path, current_path
    refute page.has_content? item1.title

    visit admin_item_path(item2)
    click_on "Delete"

    assert_equal admin_items_path, current_path
    refute page.has_content? item2.title
  end

  test "admin deletes an item from the item show page" do
    admin = create(:admin)
    item = create(:item)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_item_path(item)
    click_on "Delete"

    assert_equal admin_items_path, current_path
    refute page.has_content? item.title
  end

  test "admin cannot delete an item that has been ordered" do
    admin = create(:admin)
    item = create(:item)
    order = create(:order)
    order.items << item

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_item_path(item)
    click_on "Delete"

    error_msg = "Cannot delete an item that has been ordered." \
                " Suggest making it inactive instead."

    assert page.has_content? error_msg
    assert_equal 1, Item.count
  end
end
