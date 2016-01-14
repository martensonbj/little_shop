class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def create
    order = Order.create(user_id: current_user.id)
    @cart.contents.each do |item_id, quantity|
      OrderItem.create(order_id: order.id, item_id: item_id, quantity: quantity)
    end

    @cart.contents.clear
    flash[:success] = "Order was successfully placed"
    redirect_to orders_path(order_id: order.id)
  end
end
