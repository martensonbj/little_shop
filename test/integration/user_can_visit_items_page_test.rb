require 'test_helper'

class UserCanVisitItemsPageTest < ActionDispatch::IntegrationTest
  test "User visits items page and sees exisiting items" do
    artist = Artist.create(first_name: "Bruce", last_name: "Wayne")
    item1 = Item.create(title: "Darkness", image_path: "https://s-media-cache-ak0.pinimg.com/236x/ac/79/ec/ac79ecfd60f82e28cabdfb8f1dc10df4.jpg")
    item2 = Item.create(title: "Parents", image_path: "something")


    visit items_path
    assert page.has_content? "Darkness"
    assert page.has_content? "Parents"
  end
end
