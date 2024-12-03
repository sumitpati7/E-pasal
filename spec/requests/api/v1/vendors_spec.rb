require 'rails_helper'

RSpec.describe "Api::V1::Vendors", type: :request do
  describe "GET /show" do
    let(:vendor) {
      Vendor.create!(email: "abc@gmail.com", password: "1234abcd", owner_name: "ven", shop_name: "dorshop", address: "ven dor", contact_number: "9876543210")
    }

    it "returns a list of products added by that particular vendor" do
      get "/api/v1/vendors/#{vendor.id}"
      # expect(response).to have_http_status(:ok) # expecting valid status code
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["message"]).to eq("Vendor found")
    end

    it "returns an error when vendor is not found" do
      get "/api/v1/vendors/111"
      # expect(response).to have_http_status(:not_found)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["message"]).to eq("Vendor not found")
    end
  end
end
