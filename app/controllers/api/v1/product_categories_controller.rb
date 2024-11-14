module Api
  module V1
    class ProductCategoriesController < ApplicationController
      def index
        categories=ProductCategory.all
        render json: categories.as_json(only: [ :id, :name ])
      end
    end
  end
end
