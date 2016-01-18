class OrdersController < ApplicationController
  before_action :require_user, only: [:index, :show]

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
      redirect_to user_orders_path(current_user.slug, order_id: order.id)
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def require_user
    render file: "public/404" unless current_admin? ||
                                     current_user.id == params[:user_id].to_i
  end
end
