class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def update_quantity(item_id, new_quantity)
    contents[item_id] = new_quantity.to_i
  end

  def delete_item(item_id)
    contents.delete(item_id.to_s)
  end

  def clear
    @contents.clear
  end

  def empty?
    @contents.empty?
  end

  def item_quantities
    contents.map do |item_id, quantity|
      [Item.find(item_id.to_i), quantity]
    end
  end

  def count
    contents.values.reduce(:+)
  end

  def total_price
    item_quantities.inject(0) do |sum, item_and_quantity|
      sum + (item_and_quantity[0].price * item_and_quantity[1])
    end
  end
end
