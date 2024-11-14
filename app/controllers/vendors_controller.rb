class VendorsController < ApplicationController
  before_action :authenticate_vendor!

  def index
    @vendor = Vendor.includes(:products).find(current_vendor.id)
  end

  def show
  end
end
