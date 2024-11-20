class ProductCategorySerializer < ActiveModel::Serializer
    attributes :id, :name, :icon
    has_many :products, serializer: ProductSerializer
  end