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
    select('New York', :from => 'user_state')
    click_on "Update User"

    assert_equal dashboard_path, current_path
    assert page.has_content? "Gotham"
    assert page.has_content? "NY"
  end
end
