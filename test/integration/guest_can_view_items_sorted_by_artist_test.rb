require "test_helper"

class GuestCanViewItemsSortedByArtistTest < ActionDispatch::IntegrationTest
  test "items are shown under their assigned artist" do
    artist1 = create(:artist_with_items)
    artist2 = create(:artist_with_items)
    user = create(:user)

    visit artists_path

    assert page.has_content?(artist1.full_name)
    within "\##{artist1.username}" do
      assert page.has_content?(artist1.items.first.title)
      assert page.has_content?(artist1.items.last.title)
      refute page.has_content?(artist2.items.first.title)
      refute page.has_content?(artist2.items.last.title)
    end

    assert page.has_content?(artist2.full_name)
    within "\##{artist2.username}" do
      assert page.has_content?(artist2.items.first.title)
      assert page.has_content?(artist2.items.last.title)
      refute page.has_content?(artist1.items.first.title)
      refute page.has_content?(artist1.items.last.title)
    end

    refute page.has_content?(user.full_name)
  end
end
