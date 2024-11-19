module Api
  module V1
    class ProductCategoriesController < Api::V1::ApplicationController
      def index
        categories=ProductCategory.all
        render json: categories, each_serializer: ProductCategorySerializer
      end
      def show
        category=ProductCategory.find_by(id: params[:id])
        if category
          render json: {
            message: "Category Found",
            data: category
          }, status: :ok
        else
          render json: {
            "message": "Category Not Found"
          }, status: :not_found
        end
      end
    end
  end
end
