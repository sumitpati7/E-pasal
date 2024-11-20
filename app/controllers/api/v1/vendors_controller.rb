module Api
  module V1
    class VendorsController < Api::V1::ApplicationController
      def show
        begin
          vendor=Vendor.find(params[:id])
          # render json: vendor, each_serializer: VendorSerializer
          render json: { message: "Vendor found", data: VendorSerializer.new(vendor).as_json }
        rescue
          render json: { message: "Vendor not found" }
        end
      end
    end
  end
end
