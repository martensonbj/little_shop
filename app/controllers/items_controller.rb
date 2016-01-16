class ItemsController < ApplicationController
  def index
    @items = Item.active
  end

  def show
    @item = Item.find(params[:id])
  end
end
