require "test_helper"

class UserRemovesItemFromCartTest < ActionDispatch::IntegrationTest
  test "item is removed from current cart" do
    create_and_add_item_to_cart
    visit cart_path

    click_link "Remove"
    assert_equal cart_path, current_path

    success_message = "Successfully removed #{@item.title} from your cart."
    assert page.has_content?(success_message)
    assert page.has_css?(".flash_success")
    assert page.has_link?(@item.title, href: item_path(@item))

    within ".container" do
      refute page.has_content?(@item.title)
    end
  end

  def create_and_add_item_to_cart
    @item = create(:item)

    visit item_path(@item)
    click_button "Add to Cart"
  end
end
