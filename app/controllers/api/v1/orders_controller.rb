class Api::V1::OrdersController < Api::V1::ApplicationController
  def index
    orders = Order.where("user_id": params[:user_id])
    if orders.empty?
      render json: { message: "No orders found", orders: nil }
    else
      render json: { message: "Orders found", orders: orders.map { |order| OrderSerializer.new(order).serializable_hash } }
    end
  end

  def show
    order=Order.find_by(id: params[:id])
    if order
      render json: { message: "Order found", data: order }, status: :ok
    else
      render json: { message: "Order Not Found" }, status: :not_found
    end
  end

  def create
    params["order_products"].each do |order_product|
      pid = order_product["product_id"]
      quantity = order_product["quantity"].to_i
      product = Product.find_by_id(pid)
      render json: { error: "No product available " }, status: 404 and return if product.nil?
      if quantity >= product.stock
        render json: { error: "Too many quantity ordered" }, status: 422 and return
      end
    end

    order = Order.new(user_id: params[:user_id])
    if order.save
      order_products = order.order_products.build(products_params)
      if order_products.all? { |order_product| order_product.save }
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
    end
  end

  private

  def order_params
    params.permit(:user_id)
  end

  def product_params(orderProduct)
    orderProduct.permit(:product_id, :quantity)
  end

  def products_params
    params.require(:order_products).map do |product|
      product.permit(:product_id, :quantity)
    end
  end
end
