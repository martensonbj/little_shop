require "test_helper"

class UserCanViewItemsFromAnIndividualArtistTest < ActionDispatch::IntegrationTest
  test "user sees only items from the specific artist" do
    artist1 = create(:artist_with_items)
    artist2 = create(:artist_with_items)

    visit artists_path
    click_link artist1.full_name

    assert_equal artist_path(artist1), current_path

    assert page.has_content?("#{artist1.items.first.title}")
    assert page.has_content?("#{artist1.items.last.title}")
    refute page.has_content?("#{artist2.items.first.title}")
    refute page.has_content?("#{artist2.items.last.title}")
  end
end
