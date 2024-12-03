require 'rails_helper'

RSpec.describe "Api::V1::ProductsController", type: :request do
    # Create a Vendor
    let(:vendor) do
      Vendor.create!(email: "dikesh2@gmail.com", password: "123456789", owner_name: "Vendor Owner", shop_name: "Vendor Shop", address: "Bhaktapur", contact_number: "9876543210")
    end
    # Create a Product Category
    let(:product_category){ProductCategory.create!(name: "Electronics10", icon: "electronics_icon.png")}

    # Create Products
    let(:product) do
      Product.create!(
        title: "Product A",
        brand: "Brand A",
        description: "Description A",
        price: 100,
        stock: 5,
        discount_percentage: 10,
        product_category_id: product_category.id,
        vendor_id: vendor.id
      )
    end

  describe "GET #index" do
    it "returns a list of paginated products with metadata" do
      get "/api/v1/products", params: { page: 1, per_page: 2 }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Products Found")
      expect(json["data"].length).to eq(2)
    end
  end

  describe "GET #show" do
    context "when the product exists" do
      it "returns the product details" do
        get "/api/v1/products/#{product.id}"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["message"]).to eq("Record Found")
        expect(json["data"]["title"]).to eq("Product A")
      end
    end

    context "when the product does not exist" do
      it "returns an error message" do
        get "/api/v1/products/999999"

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["message"]).to eq("Record not found")
      end
    end
  end

  describe "GET #search" do
    it "returns products matching the keyword" do
      get "/api/v1/products/search", params: { keyword: "Product A" }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Search Results")
    end

    it "returns no products when the keyword does not match" do
      get "/api/v1/products/search", params: { keyword: "Nonexistent Product" }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Search Results")
      expect(json["result"].length).to eq(0)
      puts json["result"]

    end
  end
end
