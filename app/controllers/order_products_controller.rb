class OrderProductsController < ApplicationController
  def edit
    @orderProduct = OrderProduct.find(params[:id])
  end

  def update
    @orderProduct = OrderProduct.find(params[:id])
    if @orderProduct.update(orderProduct_params)
      if @orderProduct.shipped? || @orderProduct.cancelled?
        redirect_to orders_path, alert: "Status updated and Order Deleted!"
      else
        redirect_to orders_path, notice: "Status updated"
      end
    end
  end

  private
  def orderProduct_params
    params.require(:order_product).permit(:status)
  end
end
