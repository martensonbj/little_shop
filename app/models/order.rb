class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: %w(ordered paid cancelled completed)

  def date
    created_at.strftime("%b %d, %Y %I:%M%P")
  end

  def total
    order_items.inject(0) do |sum, order_item|
      sum + (order_item.quantity * items.find(order_item.item_id).price).to_i
    end
  end

  def quantity_of_item(item_id)
    order_items.find_by(item_id: item_id).quantity
  end

  def self.count_of_ordered
    where(status: 0).count
  end

  def self.count_of_paid
    where(status: 1).count
  end

  def self.count_of_cancelled
    where(status: 2).count
  end

  def self.count_of_completed
    where(status: 3).count
  end
end
