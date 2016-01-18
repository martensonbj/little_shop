class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end
end
