require "test_helper"

class GuestCanChangeQuanityInCartTest < ActionDispatch::IntegrationTest
  test "guest visits cart and adds more items" do
    add_items_to_cart_and_visit_shopping_cart(1)
    item = @items.first
    visit cart_path

    assert page.has_content? "Total: $#{item.price * 1}"

    fill_in "Quantity", with: "4"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Total: $#{item.price * 4}"
    assert page.has_content? "Subtotal: $#{item.price * 4}"

    fill_in "Quantity", with: "2"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Total: $#{item.price * 2}"
    assert page.has_content? "Subtotal: $#{item.price * 2}"
  end

  test "the quantity defaults to previous quantity if set to negative" do
    add_items_to_cart_and_visit_shopping_cart(1)
    visit cart_path

    fill_in "Quantity", with: "-2"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Invalid item quantity"
    assert page.has_content? "1"
  end

  test "the quantity defaults to previous quantity if set to letters" do
    add_items_to_cart_and_visit_shopping_cart(1)
    visit cart_path

    fill_in "Quantity", with: "abc"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Invalid item quantity"
    assert page.has_content? "1"
  end

  test "removes item if quantity is set to zero" do
    add_items_to_cart_and_visit_shopping_cart(1)
    item = @items.first
    visit cart_path

    fill_in "Quantity", with: "0"
    click_button "Update"

    assert_equal "/cart", current_path
    refute page.has_content? item.title
  end
end
