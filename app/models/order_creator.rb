class OrderCreator
  def create(user, cart_contents)
    order = Order.create(user_id: user.id)

    cart_contents.each do |item_id, quantity|
      OrderItem.create(order_id: order.id,
                       item_id:  item_id,
                       quantity: quantity)
    end

    order
  end
end
