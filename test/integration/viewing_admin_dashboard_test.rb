require "test_helper"

class ViewingAdminDashboardTest < ActionDispatch::IntegrationTest
  test "registered admin can view the admin dashboard when logged in" do
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    assert page.has_content?("Admin Dashboard")
  end

  test "registered user cannot view the admin dashboard when logged in" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_dashboard_path
    message_404 = "The page you were looking for doesn't exist (404)"
    assert page.has_content?(message_404)
  end

  test "unregistered user cannot view the admin dashboard" do
    visit admin_dashboard_path
    message_404 = "The page you were looking for doesn't exist (404)"
    assert page.has_content?(message_404)
  end
end
