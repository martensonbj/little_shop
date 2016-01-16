require "test_helper"

class UserCannotUpdateItemQuantityToBeNegativeTest < ActionDispatch::IntegrationTest
  test "the quantity defaults to one if set to negative" do
    add_items_to_cart_and_visit_shopping_cart(1)
    @item = @items.first
    visit cart_path

    fill_in "Quantity", with: "-2"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Item quantity cannot be negative"
    assert page.has_content? "1"
  end
end
