require "test_helper"

class UserLogInTest < ActionDispatch::IntegrationTest
  test "registered user logs in and is taken to their dashboard" do
    user = create(:user)
    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    within "form" do
      click_button "Login"
    end

    assert_equal "/dashboard", current_path
    within(".nav-wrapper") do
      assert page.has_content?("Logged in as #{user.first_name}")
    end

    refute page.has_content?("Login")
    assert page.has_content?("Logout")
  end

  test "unregistered user cannot log in" do
    visit login_path

    fill_in "Username", with: "user"
    fill_in "Password", with: "password"
    within "form" do
      click_button "Login"
    end

    assert page.has_content?("Invalid login credentials")
    assert page.has_content?("Login")
    refute page.has_content?("Logout")
  end

  test "user cannot login with incorrect password" do
    user = create(:user)
    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: "wrong_password"
    within "form" do
      click_button "Login"
    end

    assert page.has_content?("Invalid login credentials")
    assert page.has_content?("Login")
    refute page.has_content?("Logout")
  end

  test "user cannot login with incorrect username" do
    create(:user)
    visit login_path

    fill_in "Username", with: "wrong_user"
    fill_in "Password", with: "password"
    within "form" do
      click_button "Login"
    end

    assert page.has_content?("Invalid login credentials")
    assert page.has_content?("Login")
    refute page.has_content?("Logout")
  end
end
