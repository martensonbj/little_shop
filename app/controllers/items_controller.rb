class ItemsController < ApplicationController
  before_action :require_artist, only: [:new, :create, :edit, :update]
  before_action :item_belongs_to_current_artist,
                only: [:edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
    item = Item.find(params[:id])
    @item = ItemPresenter.new(item, view_context)
  end

  def new
    @item = Item.new
  end

  def create
    sanitize_price(params[:item][:price])
    @item = current_user.items.new(item_params)

    if @item.save
      redirect_to @item
    else
      flash.now[:error] = "Incomplete form"
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    sanitize_price(params[:item][:price])
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      flash.now[:error] = "All fields must be filled in."
      render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])

    if @item.orders.empty?
      @item.destroy
    else
      flash[:error] = "Cannot delete an item that has been ordered." \
                      " Suggest making it inactive instead."
    end

    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:title,
                                 :image_path,
                                 :price,
                                 :description,
                                 :category_id,
                                 :status,
                                 :file_upload)
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
