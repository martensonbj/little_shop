class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_slug(params[:slug])
  end

  def index
    @categories = Category.all.includes(:items)
  end

  private

  def category_params
    params.require(:category).permit(:name, :slug)
  end

end
