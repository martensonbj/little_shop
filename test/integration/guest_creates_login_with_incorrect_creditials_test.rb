require "test_helper"

class GuestCreatesLoginWithIncorrectCreditialsTest < ActionDispatch::IntegrationTest
  test "guest puts in incorrect password confirmation and gets error message" do
    visit new_user_path
    fill_in "First name", with: "Bruce"
    fill_in "Last name", with: "Wayne"
    fill_in "Username", with: "Batman"
    fill_in "Password", with: "darkness"
    fill_in "Password confirmation", with: "parents_dead"
    click_on "Create User"

    assert_equal users_path, current_path
    assert page.has_content? "Password confirmation doesn't match Password"
  end

  test "guest puts in name that is already created" do
    user = create(:user)

    visit new_user_path
    fill_in "First name", with: "Bruce"
    fill_in "Last name", with: "Wayne"
    fill_in "Username", with: user.username
    fill_in "Password", with: "darkness"
    fill_in "Password confirmation", with: "darkness"
    click_on "Create User"

    assert_equal users_path, current_path
    assert page.has_content? "Username has already been taken"
  end
end
