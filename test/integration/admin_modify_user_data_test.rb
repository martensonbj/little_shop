require "test_helper"

class AdminModifyUserDataTest < ActionDispatch::IntegrationTest
  test "admin modifies their own data" do
    admin = create(:admin)
    visit login_path

    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    within "form" do
      click_on "Login"
    end

    visit admin_dashboard_path
    click_on "Edit Info"

    assert_equal edit_user_path(admin), current_path

    select('New York', :from => 'user_state')
    fill_in "City", with: "Gotham"
    click_on "Update User"

    assert_equal admin_dashboard_path, current_path
    assert page.has_content? "Gotham"
    assert page.has_content? "NY"
  end
end
