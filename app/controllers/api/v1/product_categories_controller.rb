module Api
  module V1
    class ProductCategoriesController < Api::V1::ApplicationController
      def index
        categories=ProductCategory.all
        render json: categories, each_serializer: ProductCategoriesSerializer
      end
      def show
        category=ProductCategory.find_by(id: params[:id])
        if category
          render json: {
            message: "Category Found",
            data: ProductCategorySerializer.new(category).as_json
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
