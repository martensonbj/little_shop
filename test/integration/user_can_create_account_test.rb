require 'test_helper'

# As a visitor
#     When I visit "/"
#     Then I should see a link for "Login"
#     And when I click link "Create Account"
#     Then my current page should be "/dashboard"
#     And I should see a message in the navbar that says "Logged in as SOME_USER"
#     And I should see my profile information
#     And I should not see a link for "Login"
#     And I should see a link for "Logout"

class UserCanCreateAccountTest < ActionDispatch::IntegrationTest
  test "user can create account and sees profile" do
    visit '/'
    assert page.has_content?("Login")
    click_link_or_button 'Create Account'

    assert_equal new_user_path, current_path

    fill_in "First name", with: "Brenna"
    fill_in "Last name", with: "Martenson"
    fill_in "Username", with: "brenna"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"
    user = User.last

    assert_equal '/dashboard', current_path
    within ('.nav-wrapper') do
      assert page.has_content?("Logged in as #{user.first_name}")
    end
    refute page.has_content?("Login")
    assert page.has_content?("Logout")
  end
end
