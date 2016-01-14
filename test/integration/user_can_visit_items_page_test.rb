require 'test_helper'

class UserCanVisitItemsPageTest < ActionDispatch::IntegrationTest
  test "User visits items page and sees exisiting items" do
    artist = create(:artist_with_items)
    items = artist.items
    visit items_path
    assert page.has_content? "#{items.first.title}"
    assert page.has_content? "#{items.last.title}"
    assert page.has_css?("img[src*='#{items.first.image_path}']")
    assert page.has_css?("img[src*='#{items.last.image_path}']")
  end
end
