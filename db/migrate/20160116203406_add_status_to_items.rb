class AddStatusToItems < ActiveRecord::Migration
  def change
    add_column :items, :status, :integer, default: 1
  end
end
