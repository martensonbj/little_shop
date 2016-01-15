class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id).includes(:items)
  end

  def create
    if @cart.empty?
      flash[:error] = "Cannot place an order with no items"
      redirect_to cart_path
    else
      order = OrderCreator.new.create(current_user, @cart.contents)
      @cart.clear

      flash[:success] = "Order was successfully placed"
      redirect_to orders_path(order_id: order.id)
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
