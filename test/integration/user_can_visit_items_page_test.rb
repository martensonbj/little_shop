require 'test_helper'

class UserCanVisitItemsPageTest < ActionDispatch::IntegrationTest
  test "User visits items page and sees exisiting items" do
    artist = create(:artist_with_items)
    items = artist.items
    visit items_path

    assert page.has_content? "title1"
    assert page.has_content? "title2"
    assert page.has_css?("img[src*='#{items.first.image_path}']")
    assert page.has_css?("img[src*='#{items.last.image_path}']")

  end
end
