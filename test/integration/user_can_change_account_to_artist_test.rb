require "test_helper"

class UserCanChangeAccountToArtistTest < ActionDispatch::IntegrationTest
  test "User can change account to artist" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit dashboard_path
    click_on "Edit Info"

    assert_equal edit_user_path(user), current_path

    fill_in "City", with: "Gotham"
    select("artist", from: "user_role")
    click_on "Update User"

    save_and_open_page
    assert page.has_content? "Gotham"
    byebug
    assert_equal "artist", user.role


  end
end
# As a registered user,
# When I visit my user dashboard,
# And I click on edit info,
# And I select user type: 'Artist',
# And I click on update user,
# Then I should be taken to my user dashboard,
# And I should see a link for creating items,
# And I should see a link for viewing my items
