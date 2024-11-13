class ProductsController < ApplicationController
  before_action :authenticate_vendor!
  def new
    @product=Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path, notice: "The Product was added sucessfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :brand, :description, :price, :product_category_id, :stock, :vendor_id, :discount_percentage, :product_image)
  end
end
