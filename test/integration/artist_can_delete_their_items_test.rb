require 'test_helper'

class ArtistCanDeleteTheirItemsTest < ActionDispatch::IntegrationTest
  test "artist_can_delete_their_own_ideas" do
    artist = create(:artist_with_items)
    item1, item2 = artist.items
    ApplicationController.any_instance.stubs(:current_user).returns(artist)

    visit item_path(item1)
    click_on "Delete"

    assert_equal items_path, current_path
    refute page.has_content? item1.title
    assert page.has_content? item2.title
  end
end
