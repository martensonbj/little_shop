require "test_helper"

class ArtistCanDeleteTheirItemsTest < ActionDispatch::IntegrationTest
  test "artist can delete their own item" do
    artist = create(:artist_with_items)
    item1, item2 = artist.items
    ApplicationController.any_instance.stubs(:current_user).returns(artist)

    visit item_path(item1)
    click_on "Delete"

    assert_equal items_path, current_path
    refute page.has_content? item1.title
    assert page.has_content? item2.title
  end

  test "artist cannot delete another artist's item" do
    artist1 = create(:artist)
    item1 = create(:item)
    artist1.items << item1

    artist2 = create(:artist)
    item2 = create(:item)
    artist2.items << item2

    ApplicationController.any_instance.stubs(:current_user).returns(artist1)

    visit item_path(item2)
    refute page.has_content? "Delete"
  end
end
