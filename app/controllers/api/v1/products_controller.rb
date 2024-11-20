# class Api::V1::ProductsController < ApplicationController
module Api
  module V1
    class ProductsController < Api::V1::ApplicationController
        def index
          products=Product.all
          render json:
          { message: "Products Found",
          data: products.map { |product| AllProductSerializer.new(product).serializable_hash }
          }, status: :ok
        end

        def show
          begin product=Product.find(params[:id])
          # render json: product.as_json(only: [ :id, :name, :brand, :description, :price, :product_category_id, :stock, :discount_percentage, :created_at, :updated_at, :vendor_id ])
          # render json: product, each_serializer: ProductSerializer
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
