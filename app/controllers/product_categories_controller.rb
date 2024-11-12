class ProductCategoriesController < ApplicationController
  def new
    @category=ProductCategory.new
  end
  def create
    @category=ProductCategory.new(category_params)
    if @category.save
      redirect_to root_path, notice: "A Category was added sucessfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.require(:product_category).permit(:name)
  end
end
