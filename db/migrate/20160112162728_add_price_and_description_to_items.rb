class AddPriceAndDescriptionToItems < ActiveRecord::Migration
  def change
    add_column :items, :price, :float
    add_column :items, :description, :text
  end
end
