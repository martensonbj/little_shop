require "test_helper"

class UserCanEditTheirInfoTest < ActionDispatch::IntegrationTest
  test "user modifies their own data" do
    user = create(:user)
    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    within "form" do
      click_on "Login"
    end

    visit dashboard_path
    click_on "Edit Info"

    assert_equal edit_user_path(user), current_path

    fill_in "City", with: "Gotham"
    select('New York', from: 'user_state')
    click_on "Update User"

    assert_equal dashboard_path, current_path
    assert page.has_content? "Gotham"
    assert page.has_content? "NY"
  end

  test "user cannot leave required fields blank when updating info" do
    user = create(:user)
    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    within "form" do
      click_on "Login"
    end

    visit dashboard_path
    click_on "Edit Info"

    assert_equal edit_user_path(user), current_path

    fill_in "City", with: ""
    click_on "Update User"

    assert page.has_content? "Incorrect user information"
  end

  test "user cannot visit edit page for another user" do
    user1 = create(:user)
    user2 = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(user1)

    visit edit_user_path(user2)

    message_404 = "The page you were looking for doesn't exist (404)"
    assert page.has_content? message_404
  end
end
