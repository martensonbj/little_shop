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

      @amount = @cart.total_price * 100

      customer = Stripe::Customer.create(
        email:  params[:stripeEmail],
        source: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer:    customer.id,
        amount:      @amount,
        description: "Rails Stripe customer",
        currency:    "usd"
      )

      @cart.clear

      flash[:success] = "Order was successfully placed"
      redirect_to user_orders_path(current_user.slug, order_id: order.id)
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to cart_path
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def require_user
    render file: "public/404" unless current_admin? ||
                                     current_user.slug == params[:user_slug]
  end
end
