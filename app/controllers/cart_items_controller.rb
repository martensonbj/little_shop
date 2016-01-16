class CartItemsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:success] = "You added #{item.title} to your cart."

    redirect_to request.referer
  end

  def index
    @items_with_quantities = @cart.item_quantities
    @total = @cart.total_price
  end

  def update
    if quantity_is_invalid
      flash[:error] = "Invalid item quantity"
    elsif quantity_is_zero
      item = Item.find(params[:id])
      @cart.delete_item(item.id)
    else
      @cart.update_quantity(params[:id], params[:quantity])
    end

    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:id])
    @cart.delete_item(item.id)

    link_to_item = "#{view_context.link_to(item.title, item)}"
    flash[:success] = "Successfully removed #{link_to_item} from your cart."

    redirect_to cart_path
  end

  private

  def quantity_is_invalid
    quantity_is_negative || quantity_is_not_a_number
  end

  def quantity_is_negative
    params[:quantity].to_i < 0
  end

  def quantity_is_not_a_number
    (params[:quantity] =~ /\d/).nil?
  end

  def quantity_is_zero
    params[:quantity] == "0"
  end
end
