require "test_helper"

class GuestCanViewItemsSortedByCategoryTest < ActionDispatch::IntegrationTest
  test "items are shown under their assigned category" do
    category1 = create(:category_with_items)
    category2 = create(:category_with_items)

    visit categories_path

    assert page.has_content?(category1.name)
    within "\##{category1.name}" do
      assert page.has_content?(category1.items.first.title)
      assert page.has_content?(category1.items.last.title)
      refute page.has_content?(category2.items.first.title)
      refute page.has_content?(category2.items.last.title)
    end

    assert page.has_content?(category2.name)
    within "\##{category2.name}" do
      assert page.has_content?(category2.items.first.title)
      assert page.has_content?(category2.items.last.title)
      refute page.has_content?(category1.items.first.title)
      refute page.has_content?(category1.items.last.title)
    end
  end
end
