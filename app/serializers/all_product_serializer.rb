class AllProductSerializer < ActiveModel::Serializer
    attributes :id, :name, :image_urls, :brand, :price
  end