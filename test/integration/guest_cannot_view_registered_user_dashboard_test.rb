require "test_helper"

class GuestCannotViewRegisteredUserDashboardTest < ActionDispatch::IntegrationTest
  test "guest sees 404 if they try to visit user dashboard page directly" do
    visit dashboard_path

    message_404 = "The page you were looking for doesn't exist (404)"
    assert page.has_content? message_404
  end
end
