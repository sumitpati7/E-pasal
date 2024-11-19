class Api::V1::OrdersController < Api::V1::ApplicationController
  def index
    orders = Order.where("user_id": params[:user_id])
    render json: orders
  end


  def create
    order = Order.new(user_id: params[:user_id])

    if order.save
      if params[:order_products].present?
        # order_products = order.order_products.build(products_params)
        order_products = order.order_products.build(products_params)

        # if order_products.all?(&:save)
        if order_products.all? { |product| product.save }
          render json: {
            message: "Order and associated products created successfully.",
            order: order,
            products: order_products
          }, status: :created
        else
          render json: {
            message: "Order created, but failed to save associated products.",
            errors: order_products.map(&:errors).flat_map(&:full_messages)
          }, status: :unprocessable_entity
        end
      else
        render json: { message: "Order created successfully.", order: order }, status: :created
      end
    else
      render json: { message: "Failed to create order.", errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.permit(:user_id)
  end

  def products_params
    params.require(:order_products).map do |product|
      product.permit(:product_id, :quantity)
    end
  end
end
