class Admin::ItemsController < Admin::BaseController
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      byebug
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :image_path, :price, :description, :category_id, :user_id)
  end
end
