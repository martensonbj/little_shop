require "test_helper"

class ArtistCanUploadPhotoTest < ActionDispatch::IntegrationTest
  test "artist can upload a photo" do
    artist = create(:artist)
    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(artist)

    visit dashboard_path
    click_on "Add New Item"

    assert_equal new_user_item_path(artist), current_path

    fill_in "Title", with: "Meat"
    attach_file("item_file_upload", fixture_image_path)
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select "#{category.name}", from: "item_category_id"
    click_on "Create Item"

    item = Item.last
    assert_equal artist, item.user
    assert_equal item_path(item), current_path
    assert page.has_css?("img[src*='#{item.file_upload_file_name}']")
    assert page.has_content? item.user.full_name

    visit items_path
    assert page.has_css?("img[src*='#{item.file_upload_file_name}']")
  end

  def fixture_image_path
    Rails.root.join("test", "helpers", "test_image.jpg")
  end
end
