require 'rails_helper'

RSpec.describe "Api::V1::Comments", type: :request do
  let(:user) { User.create!(email: "habi11111@gmail.com", password: "123456789", first_name: "habi", last_name: "Pyatha", address: "Thimi", contact_phone: "9876543212") }
  let(:vendor) { Vendor.create!(email: "habi22222@gmail.com", password: "123456789", owner_name: "habi", shop_name: "Pro", address: "thimi", contact_number: "9876543211") }
  let(:category) { ProductCategory.create!(name: "Powerbank12") }
  let(:product) { Product.create!(title: "PowerBank12", brand: "X-age", description: "best for the price", price: "2500", product_category_id: category.id, stock: 100, discount_percentage: 23, vendor_id: vendor.id) }
  let(:comment) { Comment.create!(content: "Nice Product", user_id: user.id, product_id: product.id) }

  describe "POST /create" do
    it "posts a comment with valid argument" do
      post "/api/v1/products/#{product.id}/comments", params: {
        content: "Nice Product",
        user_id: user.id
      }
      expect(response.status).to eql(200)
    end

    it "posts a comment with invalid User ID" do
      post "/api/v1/products/#{product.id}/comments", params: {
        content: "Nice Product",
        user_id: 75
      }
      expect(response.status).to eql(400)
    end

    it "posts a comment with no comment content" do
      post "/api/v1/products/#{product.id}/comments", params: {
        user_id: 1
      }
      expect(JSON.parse(response.body)['message']).to include("Content can't be blank")
    end

    it "posts a comment without user id" do
      post "/api/v1/products/#{product.id}/comments", params: {
        content: "Nice Product"
      }
      expect(JSON.parse(response.body)['message']).to include("User must exist")
    end

    it "posts a comment without user id" do
      post "/api/v1/products/#{product.id}/comments", params: {
        content: "Nice Product",
        user_id: 6
      }
      expect(JSON.parse(response.body)['message']).to include("User must exist")
    end
  end

  describe "DELETE /destroy" do
    it "comment is destroyed with valid comment ID" do
      delete api_v1_product_comment_path(product.id, comment.id)
      expect(response).to have_http_status :ok
    end

    it "comment is not destroyed without valid product ID " do
      delete api_v1_product_comment_path(100545, comment.id)
      expect(response).to have_http_status :not_found
    end

    it "comment is not destroyed without valid comment ID " do
      delete api_v1_product_comment_path(product.id, 45)
      expect(response).to have_http_status :not_found
    end
  end
end
