class ProductsController < ApplicationController
  before_action :set_vendor
  def new
    @product=Product.new
    # @product=@vendor.products.build
    # puts ("curr #{current_vendor}")
  end

  def create
    # vendor=vendor.find(current_vendor.id)
    # product=vendor.product
    # product=vendor.build_product()
    # puts("This is just test",@vendor)
    @product=@vendor.products.build(product_params)
    # @product=Product.new(product_params)
    if @product.save
      redirect_to vendor_path(@vendor), notice: "The Product was added sucessfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def set_vendor
    # @vendor=Vendor.find(params[:id])
    @vendor=Vendor.find(current_vendor.id)
    # puts("current vendor #{current_vendor}")
    # @vender=current_vendor
  end

  def product_params
    params.require(:product).permit(:name, :brand, :description, :price, :product_category_id, :stock, :discount_percentage, product_image: [])
  end
end
