# class Api::V1::ProductsController < ApplicationController
module Api
  module V1
    class ProductsController < Api::V1::ApplicationController
        def index
          page = params[:page].present? ? params[:page] : 1
          per_page = params[:per_page].present? ? params[:per_page] : 8
          products=Product.all.page(page).per(per_page)
          render json: {message: "Products found", products: products, total_pages: products.total_pages, previous_page: products.prev_page, next_page: products.next_page, next_page_url: products.next_page ? url_for(page: products.next_page) : nil,
          prev_page_url: products.prev_page ? url_for(page: products.prev_page) : nil }
        end 

        def show
          begin product=Product.find(params[:id])
          render json: {
            message: "Record Found",
            data: ProductSerializer.new(product).as_json
          }
          rescue ActiveRecord::RecordNotFound
            render json: { message: "Record not found" }, status: :unprocessable_entity
          end
        end

        # def create
        #   product=Product.new(product_params)
        #   if product.save
        #     render json: product, status: :created
        #   else
        #     render json: product.errors, status: :unprocessable_entity
        #   end
        # end

        # def update
        #   product=Product.find(params[:id])
        #   if model.update(product_params)
        #     render json: product
        #   else
        #     render json: product.erros, status: :unprocessable_entity
        #   end
        # end

        # def destroy
        #   product=Product.find(params[:id])
        #   product.destroy
        #   head :no_content
        # end

        private
        def product_params
          params.require(:product).permit(:name, :brand, :description, :price, :product_category_id, :stock, :vendor_id, :discount_percentage, product_image: [])
        end
    end
  end
end
