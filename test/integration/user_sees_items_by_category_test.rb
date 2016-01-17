require "test_helper"

class UserSeesItemsByCategoryTest < ActionDispatch::IntegrationTest
  test "user sees only items specified by category" do
    category1 = create(:category_with_items)
    category2 = create(:category_with_items)

    visit category_path(category1)

    assert page.has_content?("#{category1.items.first.title}")
    assert page.has_content?("#{category1.items.last.title}")
    refute page.has_content?("#{category2.items.first.title}")
    refute page.has_content?("#{category2.items.last.title}")
  end
end
