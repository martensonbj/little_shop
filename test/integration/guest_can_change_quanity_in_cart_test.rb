require "test_helper"

class GuestCanChangeQuanityInCartTest < ActionDispatch::IntegrationTest
  test "guest visits cart and adds more items" do
    add_item_to_cart_and_visit_shopping_cart
    @item = @items.first
    
    visit cart_path

    assert page.has_content? "Total: $#{@item.price * 1}"

    fill_in "Quantity", with: "4"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Total: $#{@item.price * 4}"
    assert page.has_content? "Subtotal: $#{@item.price * 4}"

    fill_in "Quantity", with: "2"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Total: $#{@item.price * 2}"
    assert page.has_content? "Subtotal: $#{@item.price * 2}"
  end
end
