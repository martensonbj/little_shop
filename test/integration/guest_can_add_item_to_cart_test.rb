require 'test_helper'

class GuestCanAddItemToCartTest < ActionDispatch::IntegrationTest

  test "guest can view item added to cart" do
    items = create_list(:item, 2)

    visit items_path

    first(:button, 'Add to Cart').click
    assert page.has_content?("You added #{items.first.title} to your cart.")

    visit item_path(items.last)

    click_button "Add to Cart"
    assert page.has_content?("You added #{items.last.title} to your cart.")

    find('#shopping_cart').click

    assert_equal cart_path, current_path
    items.each do |item|
      assert page.has_content?(item.title)
      assert page.has_content?(item.description)
      assert page.has_content?(item.price)
      assert page.has_css?("img[src*='#{item.image_path}']")
    end

    assert page.has_content?(items.first.price + items.last.price)
  end
end
