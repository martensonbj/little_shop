class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    sanitize_price(params[:item][:price])
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      flash.now[:alert] = "Incomplete form"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    sanitize_price(params[:item][:price])
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :new
      flash[:alert] = "All fields must be filled in."
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:title,
                                 :image_path,
                                 :price,
                                 :description,
                                 :category_id,
                                 :user_id,
                                 :status)
  end
end
