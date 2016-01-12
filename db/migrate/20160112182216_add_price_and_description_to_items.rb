class AddPriceAndDescriptionToItems < ActiveRecord::Migration
  def change
    add_column :items, :price, :integer
    add_column :items, :description, :text
  end
end
