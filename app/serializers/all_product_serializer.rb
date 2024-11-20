class AllProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :image_urls, :brand, :price, :discount_percentage

  def title
    object.name
  end
end
