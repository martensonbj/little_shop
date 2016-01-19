require "test_helper"

class RegisteredUserCantChangeUsernameTest < ActionDispatch::IntegrationTest
  test "registered users can edit all profile fields except username" do
    visit new_user_path
    assert page.has_content?("Username")

    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit edit_user_path(user)
    refute page.has_content?("Username")
  end
end
