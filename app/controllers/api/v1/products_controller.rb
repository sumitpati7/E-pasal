# class Api::V1::ProductsController < ApplicationController
module Api
  module V1
    class ProductsController < Api::V1::ApplicationController
        def index
          page = params[:page].present? ? params[:page] : 1
          per_page = params[:per_page].present? ? params[:per_page] : 8
          products=Product.all.page(page).per(per_page)
          render json:
          { message: "Products Found",
          data: products.map { |product| AllProductSerializer.new(product).serializable_hash },
          total_pages: products.total_pages, previous_page: products.prev_page, next_page: products.next_page, next_page_url: products.next_page ? url_for(page: products.next_page) : nil,
          prev_page_url: products.prev_page ? url_for(page: products.prev_page) : nil
          }, status: :ok
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

        def search
          keyword = params[:keyword]
          result = Product.where("name ILIKE :keyword OR description ILIKE :keyword OR brand ILIKE :keyword", keyword: "%#{keyword}%")
          if result.empty?
            render json: {
              message: "No result found"
            }
          else
            render json: {
            message: "Search Results",
            result: result.map { |product| AllProductSerializer.new(product).serializable_hash }
          }
          end
        end

        private
        def product_params
          params.require(:product).permit(:name, :brand, :description, :price, :product_category_id, :stock, :vendor_id, :discount_percentage, product_image: [])
        end
    end
  end
end
