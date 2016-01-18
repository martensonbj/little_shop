class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def update
    Order.find(params[:id]).update_attribute(:status, params[:status].to_i)

    redirect_to admin_orders_path
  end
end
