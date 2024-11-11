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
#
class Product < ApplicationRecord
  belongs_to :product_category
  has_many_attached :product_image
  has_many :comments, dependent: :destory
  has_many :order_products, dependent: :destory
  has_many :orders, through: :order_products
  has_many :users, through: :comments
end
