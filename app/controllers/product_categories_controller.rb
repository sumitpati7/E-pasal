class ProductCategoriesController < ApplicationController
  before_action :authenticate_vendor!
  def new
    @category=ProductCategory.new
  end
  def create
    @category=ProductCategory.new(category_params)
    if @category.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "A Category was added sucessfully." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.require(:product_category).permit(:name)
  end
end
