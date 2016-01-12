class CartItemsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You added #{item.title} to your cart."
    redirect_to request.referer
  end

  def index
    @items_with_quantities = @cart.item_quantities
    @total = @cart.total_price
  end
end
