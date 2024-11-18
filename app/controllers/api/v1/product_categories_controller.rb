module Api
  module V1
    class ProductCategoriesController < Api::V1::ApplicationController
      def index
        categories=ProductCategory.all
        render json: categories, each_serializer: ProductCategorySerializer
      end
    end
  end
end
