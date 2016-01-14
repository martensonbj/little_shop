class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  def date
    local_time_zone = Time.now.getlocal.zone
    created_at.in_time_zone(local_time_zone).strftime("%b %d, %Y %I:%M%P")
  end

  def total
    order_items.inject(0) do |sum, order_item|
      sum + (order_item.quantity * items.find(order_item.item_id).price).to_i
    end
  end

  def quantity_of_item(item_id)
    order_items.find_by(item_id: item_id).quantity
  end
end
