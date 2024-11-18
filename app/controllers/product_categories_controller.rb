class ProductCategoriesController < ApplicationController
  before_action :authenticate_vendor!

  def index
    @categories=ProductCategory.all.order(:id)
  end
  def new
    @category=ProductCategory.new
  end
  def create
    @category=ProductCategory.new(category_params)
    if @category.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "A Category was added sucessfully." }
        format.turbo_stream { flash.now[:notice]="The Product was added sucessfully." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    @category=ProductCategory.find(params[:id])
  end
  def update
    @category=ProductCategory.find(params[:id])
    if @category.update(category_params)
      redirect_to product_categories_path, notice: "Product updated sucessfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category=ProductCategory.find(params[:id])

    if @category.destroy
      redirect_to product_categories_path, notice: "Product Deleted sucessfully"
    end
  end

  private
  def category_params
    params.require(:product_category).permit(:name, :icon)
  end
end
