require "test_helper"

class AdminCanLoginToAdminDashboardTest < ActionDispatch::IntegrationTest
  test "admins logs in and sees admin dashboard" do
    admin = User.create(first_name: "Admin",
                     last_name: "Admin",
                     username: "admin",
                     password: "password",
                     role: 2)

    visit login_path
    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    within "form" do
      click_on "Login"
    end

    assert_equal admin_dashboard_path, current_path
  end
end
