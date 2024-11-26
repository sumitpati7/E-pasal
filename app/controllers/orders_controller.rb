class OrdersController < ApplicationController
    def index
        @orderProducts = current_vendor.order_products
    end
end
