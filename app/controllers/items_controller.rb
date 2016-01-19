class ItemsController < ApplicationController
  before_action :require_arist, only: [:new, :create]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    item = current_user.items.new(item_params)

    if item.save
      redirect_to item
    else
      flash.now[:alert] = "Incomplete form"
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title,
                                 :image_path,
                                 :price,
                                 :description,
                                 :category_id,
                                 :status)
  end

  def require_arist
    render file: "/public/404" unless current_artist?
  end
end
