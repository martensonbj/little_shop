require 'test_helper'

class AdminCanEditAnyItemTest < ActionDispatch::IntegrationTest
  test "admin edit other peoples items" do
    admin = User.create(first_name: "Admin",
                        last_name:  "Admin",
                        username:   "admin",
                        password:   "password",
                        role:       2)
    artist = create(:artist_with_items)
    category = create(:category)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit edit_admin_item_path(Item.last)
    fill_in "Title", with: "Meat"
    fill_in "Image path",
            with: "https://petenelson.com/wp-content/uploads/2011/08/ron-swanson-meat.jpg"
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select "#{category.name}", from: "item_category_id"
    select "#{artist.first_name}", from: "item_user_id"
    click_on "Complete"

    assert_equal admin_item_path(Item.last), current_path
    assert page.has_content? "Meat"
    assert page.has_content? artist.first_name
  end
end
