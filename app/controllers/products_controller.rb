class ProductsController < ApplicationController
  before_action :authenticate_vendor!
  def new
    @product=Product.new
  end

  def create

  end
end



# Primary: Charcoal (#36454f)
# Accent: Orange (#f25c54) for highlights or buttons
# Background: Off-White (#f7f7f7)
# Text: Dark Gray (#2e2e2e)