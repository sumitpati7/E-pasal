class VendorSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :email, :owner_name, :shop_name, :address, :contact_number, :created_at, :updated_at
end
