# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  brand               :string           default("No Brand"), not null
#  description         :text
#  price               :string           not null
#  product_category_id :bigint           not null
#  stock               :integer          not null
#  discount_percentage :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  vendor_id           :bigint           not null
#
class ProductSerializer < ActiveModel::Serializer
  # attributes :id, :name, :brand, :image_urls, :description, :price, :stock, :discount_percentage, :product_category_id, :vendor_id, :created_at, :updated_at
  attributes :id, :title, :brand, :images, :description, :price, :stock, :discount_percentage, :product_category_id, :vendor_id, :created_at, :updated_at
  belongs_to :product_category
  has_many :comments
  belongs_to :vendor

  def title
    object.name
  end

  def images
    object.image_urls
  end
end
