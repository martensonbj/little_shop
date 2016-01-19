class ItemsController < ApplicationController
  before_action :require_artist, only: [:new, :create, :edit, :update]
  before_action :item_belongs_to_current_artist, only: [:edit, :update]

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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])

    if item.update(item_params)
      redirect_to item
    else
      render :new
      flash[:alert] = "All fields must be filled in."
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

  def require_artist
    render file: "/public/404" unless current_artist?
  end

  def item_belongs_to_current_artist
    render file: "/public/404" unless item_user_id_is_current_user
  end

  def item_user_id_is_current_user
    Item.find(params[:id]).user.id == current_user.id
  end
end
