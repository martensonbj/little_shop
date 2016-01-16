require 'test_helper'

class AdminCanEditAnyItemTest < ActionDispatch::IntegrationTest
  test "admin edit other peoples items" do
    admin = create(:admin)
    artist = create(:artist)
    item = create(:item)
    artist.items << item
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_items_path
    click_on "Edit"

    assert_equal edit_admin_item_path(item), current_path

    fill_in "Title", with: "Meat"
    fill_in "Image path",
            with: "https://petenelson.com/wp-content/uploads/2011/08/ron-swanson-meat.jpg"
    fill_in "Price", with: "10"
    fill_in "Description", with: "Salad? That's what my food eats"
    select "#{item.category.name}", from: "item_category_id"
    select "#{artist.first_name}", from: "item_user_id"
    click_on "Complete"

    assert_equal admin_item_path(Item.last), current_path
    assert page.has_content? "Meat"
    assert page.has_content? artist.first_name
  end
end
