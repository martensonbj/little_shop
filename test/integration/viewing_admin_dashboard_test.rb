require 'test_helper'

class ViewingAdminDashboardTest < ActionDispatch::IntegrationTest
  test "admin can view the admin dashboard when logged in" do
    admin = create(:admin)
    byebug

    # As an Admin
    # When I visit "/admin/dashboard"
    # I will see a heading on the page that says "Admin Dashboard"
    #
    # As a registered user
    # When I visit "/admin/dashboard"
    # I get a 404
    #
    # As an unregistered user
    # When I visit "/admin/dashboard"
    # I get a 404
  end
end
