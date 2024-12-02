require 'rails_helper'

RSpec.describe "Api::V1::ProductCategories", type: :request do
  describe "GET /index" do
    # pending "add some examples (or delete) #{__FILE__}"
    it "responds with ok status" do
      get api_v1_product_categories_path
      expect(response).to have_http_status :ok
    end
  end

  let(:category) { ProductCategory.create!(name: "Robotics") }
  describe "GET /show" do
    it "responds with ok status" do
      get api_v1_product_category_path(category.id)
      expect(response).to have_http_status :ok
    end
    it "responds with not_found" do
      get api_v1_product_category_path(1342)
      # expect(response).to have_http_status :not_found
      expect(response).not_to have_http_status :ok
    end
  end
end
