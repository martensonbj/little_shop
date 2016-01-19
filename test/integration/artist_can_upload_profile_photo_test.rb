require "test_helper"

class UserCanUploadProfilePhotoTest < ActionDispatch::IntegrationTest
  test "artist can upload a photo" do
    artist = create(:artist)
    create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(artist)

    visit dashboard_path
    assert_equal nil, artist.file_upload_file_name
    click_on "Edit Info"

    assert_equal edit_user_path(artist), current_path
    attach_file("user_file_upload", fixture_image_path)

    click_on "Update User"
    assert page.has_css?("img[src*='#{artist.file_upload_file_name}']")

    visit artists_path
    assert page.has_css?("img[src*='#{artist.file_upload_file_name}']")
  end

  def fixture_image_path
    Rails.root.join("test", "helpers", "test_image.jpg")
  end
end
