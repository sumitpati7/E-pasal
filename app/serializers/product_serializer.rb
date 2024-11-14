class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :image_urls, :description, :price, :stock, :discount_percentage, :product_category_id, :vendor_id, :created_at, :updated_at

  
end
