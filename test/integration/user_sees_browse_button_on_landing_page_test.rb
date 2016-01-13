require 'test_helper'
class UserSeesBrowseButtonOnLandingPageTest < ActionDispatch::IntegrationTest
  test "user can visit landing page and see browse buttons" do
    visit '/'

    assert page.has_content?("Browse by Artist")
    assert page.has_content?("Browse by Category")
    assert page.has_content?("Create Account")

  end
end
