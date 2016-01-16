require "test_helper"

class AdminCanViewListingOfItemsTest < ActionDispatch::IntegrationTest
  test "admins sees a listing of items with title image and status" do
    admin = create(:admin)
    create(:artist_with_items)

    item1 = Item.first
    item2 = Item.last

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "View Items"

    assert_equal admin_items_path, current_path
    assert page.has_content? item1.title
    assert page.has_content? item2.title
    assert page.has_css?("img[src*='#{item1.image_path}']")
    assert page.has_css?("img[src*='#{item2.image_path}']")
    assert page.has_content? item1.status
    assert page.has_content? item2.status
    assert page.has_link?("Edit", href: edit_admin_item_path(item1))
    assert page.has_link?("Edit", href: edit_admin_item_path(item2))
  end
end
