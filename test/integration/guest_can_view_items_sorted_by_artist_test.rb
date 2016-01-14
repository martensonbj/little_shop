require "test_helper"

class GuestCanViewItemsSortedByArtistTest < ActionDispatch::IntegrationTest
  test "items are shown under their assigned artist" do
    artist1 = create(:artist_with_items)
    artist2 = create(:artist_with_items)

    visit artists_path

    assert page.has_content?("#{artist1.first_name} #{artist1.last_name}")
    within "\#artist_#{artist1.id}" do
      assert page.has_content?(artist1.items.first.title)
      assert page.has_content?(artist1.items.last.title)
      refute page.has_content?(artist2.items.first.title)
      refute page.has_content?(artist2.items.last.title)
    end

    assert page.has_content?("#{artist2.first_name} #{artist2.last_name}")
    within "\#artist_#{artist2.id}" do
      assert page.has_content?(artist2.items.first.title)
      assert page.has_content?(artist2.items.last.title)
      refute page.has_content?(artist1.items.first.title)
      refute page.has_content?(artist1.items.last.title)
    end
  end
end
