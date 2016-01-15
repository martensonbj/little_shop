class AddUserIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :user, index: true, foreign_key: true
  end
end
