class ProductsController < ApplicationController
  before_action :authenticate_vendor!
  def new
    @product=Product.new
  end
  def show
    @product=Product.find_by_id(params[:id])
    if @product
    else
      redirect_to root_path
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "The Product was added sucessfully." }
        format.turbo_stream { flash.now[:notice]="The Product was added sucessfully." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    # if params[:product][:product_image].present?
    #   @product.product_image.attach(params[:product][:product_image])
    # end
    if @product.update(product_params)
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Product updated successfully!" }
        format.turbo_stream
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Product successfully destroyed!" }
        format.turbo_stream
      end
    end
  end

  private
  def product_params
    params.require(:product).permit(:title, :brand, :description, :price, :product_category_id, :stock, :vendor_id, :discount_percentage, :product_image)
  end
end
