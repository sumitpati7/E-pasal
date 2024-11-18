# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  name                :string
#  brand               :string
#  description         :text
#  price               :string
#  product_category_id :bigint           not null
#  stock               :integer
#  discount_percentage :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  vendor_id           :bigint           not null
#
class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :image_urls, :description, :price, :stock, :discount_percentage, :product_category_id, :vendor_id, :created_at, :updated_at
  belongs_to :product_category
  has_many :comments
  belongs_to :vendor
end
