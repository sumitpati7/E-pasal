require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  # let(:user) { User.create!(email: "habi1@gmail.com", password: "123456789", first_name: "habi", last_name: "Pyatha", address: "thimi", contact_phone: "9876543212") }
  let(:user) { User.create!(email: "habi123@gmail.com", password: "123456789", first_name: "habi", last_name: "Pyatha", address: "Thimi", contact_phone: "9876543212") }
  let(:vendor) { Vendor.create!(email: "habi123@gmail.com", password: "123456789", owner_name: "habi", shop_name: "Pro", address: "thimi", contact_number: "9876543211") }
  let(:category) { ProductCategory.create!(name: "Powerbank123") }
  let(:product) { Product.create!(title: "PowerBank123", brand: "X-age", description: "best for the price", price: "2500", product_category_id: category.id, stock: 100, discount_percentage: 23, vendor_id: vendor.id) }
  let(:order) { Order.create!(user_id: user.id) }
  describe "GET /index" do
    # pending "add some examples (or delete) #{__FILE__}"
    context "when the user has orders" do
      before { get api_v1_user_orders_path(order.user_id) }
      it "responds with ok status" do
        expect(response).to have_http_status(:ok)
      end
      it "returns a success message" do
        expect(JSON.parse(response.body)["message"]).to eq("Orders found")
      end

      it "includes the orders in the response" do
        expect(JSON.parse(response.body)["orders"]).not_to be_empty
      end
    end
    context "when the user has no orders" do
      before { get api_v1_user_orders_path(12345) }
      it "responds with not found status" do
        expect(response).to have_http_status(:not_found)
      end
      it "returns an error message" do
        expect(JSON.parse(response.body)["message"]).to eq("No orders found")
      end
      it "does not include any orders in the response" do
        expect(JSON.parse(response.body)["orders"]).to be_nil
      end
    end
  end

  describe "GET /show" do
    context "when the order exist" do
      before { get api_v1_user_order_path(order.user_id, order.id) }
        it "responds with found status" do
          expect(response).to have_http_status :ok
        end

        it "returns a success message" do
          expect(JSON.parse(response.body)["message"]).to eq("Order found")
        end
        it "returns an order" do
          expect(JSON.parse(response.body)["data"]).not_to be_empty
        end
    end

    context "when the order does not exist jacket" do
      before { get api_v1_user_order_path(order.user_id+7876, order.id+65678) }
      it "responds with not found status" do
        expect(response).to have_http_status :not_found
      end
      it "responds with an error message" do
        expect(JSON.parse(response.body)["message"]).to eq("Order Not Found")
      end
      it "does not include any data" do
        expect(JSON.parse(response.body)["data"]).to be_nil
      end
    end
  end

  describe "POST /create" do
    let(:valid_params) do
      {
        user_id: user.id,
        order_products: [
          { product_id: product.id, quantity: 2 }
        ]
      }
    end
    let(:invalid_params_no_stock) do
      {
        user_id: user.id,
        order_products: [
          { product_id: product.id, quantity: 2030 }
        ]
      }
    end
    let(:invalid_params_no_product) do
      {
        user_id: user.id,
        order_products: [
          { product_id: product.id+987768, quantity: 1 }
        ]
      }
    end
    context "with valid params" do
      before { post api_v1_user_orders_path(user.id), params: valid_params }
      it "responds with created status" do
        expect(response).to have_http_status(:created)
      end
      it "returns a success message" do
        expect(JSON.parse(response.body)["message"]).to eq("Order and associated products created successfully.")
      end
      it "includes the created response in the response" do
        expect(JSON.parse(response.body)["order"]).to_not be_empty
      end
      it "includes the associated products in the response" do
        expect(JSON.parse(response.body)["products"]).to_not be_empty
      end
    end


    context "when a product is out of stock" do
      before { post api_v1_user_orders_path(user.id), params: invalid_params_no_stock }
      it "responds with unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "returns an error message" do
        expect(JSON.parse(response.body)["error"]).to eq("Too many quantity ordered")
      end
    end

    context "when a product does not exist" do
      before { post api_v1_user_orders_path(user.id), params: invalid_params_no_product }

      it "responds with not found status" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns an error message" do
        expect(JSON.parse(response.body)["error"]).to eq("No product available ")
      end
    end
   end
end
