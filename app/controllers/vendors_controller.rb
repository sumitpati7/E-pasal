class VendorsController < ApplicationController
  before_action :authenticate_vendor!

  def index
    @vendor = Vendor.includes(:products).find(current_vendor.id)
    @products = Product.where(vendor_id: current_vendor.id).order(:title).page(params[:page]).per(8)
  end

  def show
  end
end
