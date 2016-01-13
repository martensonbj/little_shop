require "test_helper"

class GuestCanChangeQuanityInCartTest < ActionDispatch::IntegrationTest
  test "guest visits cart and adds more items" do
    create_and_add_item_to_cart
    visit cart_path
    fill_in "Quantity", with: "4"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Total: $#{@item.price * 4}"
    refute page.has_content? "Total: $#{@item.price * 1}"

    fill_in "Quantity", with: "2"
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content? "Total: $#{@item.price * 2}"
    refute page.has_content? "Total: $#{@item.price * 4}"
  end

  def create_and_add_item_to_cart
    @item = create(:item)

    visit item_path(@item)
    click_button "Add to Cart"
  end
  #
  # Background: My cart has an item in it
  #     As a visitor
  #     When I visit "/cart"
  #     Then I should see my item with a quantity of 1
  #     And when I increase the quantity
  #     Then my current page should be '/cart'
  #     And that item's quantity should reflect the increase
  #     And the subtotal for that item should increase
  #     And the total for the cart should match that increase
  #     And when I decrease the quantity
  #     Then my current page should be '/cart'
  #     And that item's quantity should reflect the decrease
  #     And the subtotal for that item should decrease
  #     And the total for the cart should match that decrease
end
