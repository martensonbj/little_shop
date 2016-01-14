require 'test_helper'

class GuestCanViewItemsSortedByArtistTest < ActionDispatch::IntegrationTest
  test "items are shown under their assigned artist" do
    artist1 = create(:artist_with_items)
    artist2 = create(:artist_with_items)

    visit artists_path

    assert page.has_content?(artist1.name)
    within "\##{artist1.name}" do
      assert page.has_content?(artist1.items.first.title)
      assert page.has_content?(artist1.items.last.title)
      refute page.has_content?(artist2.items.first.title)
      refute page.has_content?(artist2.items.last.title)
    end

    assert page.has_content?(artist2.name)
    within "\##{artist2.name}" do
      assert page.has_content?(artist2.items.first.title)
      assert page.has_content?(artist2.items.last.title)
      refute page.has_content?(artist1.items.first.title)
      refute page.has_content?(artist1.items.last.title)
    end
  end
end
