class Api::V1::OrdersController < Api::V1::ApplicationController
  def index
    orders = Order.where("user_id": params[:user_id])
    render json: orders
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
    
    pid = params["order_products"].first["product_id"]
    quantity = params["order_products"].first["quantity"].to_i
    product = Product.find_by_id(pid)
    render json: { error: "No product available "}, status: 404 and return if product.nil?

    if quantity >= product.stock
      render json: { error: "Too many quantity ordered"}, status: 422 and return
    end

    # created_order_products = []
    # errors = []
    
    # params[:order_products].each do |order_product|
    #   new_order_product = OrderProduct.new(product_params(order_product))
    #   if new_order_product.quantity < new_order_product.product.stock
    #     created_order_products << new_order_product
    #   else
    #     errors << {order_product: new_order_product, error: "Product out of stock"}
    #   end
    # end

    # if errors.empty?
    #   order = Order.new(user_id: params[:user_id])
    #   if order.save
    #     created_order_products.each do |created_order_product|
    #       created_order_product.order_id = order.id
    #       created_order_product.save
    #     end
    #     render json: { created_order_products: created_order_products}
    #   end
    # else
    # end
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
