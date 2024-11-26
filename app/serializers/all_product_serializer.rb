class AllProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :image, :brand, :price, :discount_percentage
end
