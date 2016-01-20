require "test_helper"

class UserCanChangeAccountToArtistTest < ActionDispatch::IntegrationTest
  test "User can change account to artist" do
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
    select("artist", from: "user_role")
    click_on "Update User"

    assert_equal dashboard_path, current_path
    assert_equal "artist", User.last.role
    assert page.has_link? "Add New Item", href: new_user_item_path(user)
    assert page.has_link? "View My Items", href: artist_path(user)
    assert page.has_content? "Gotham"

    click_on "Edit Info"
    select("default", from: "user_role")
    click_on "Update User"

    assert_equal dashboard_path, current_path
    assert_equal "default", User.last.role
    refute page.has_link? "Add New Item", href: new_user_item_path(user)
    refute page.has_link? "View My Items", href: artist_path(user)
  end
end
