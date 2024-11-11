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
class Product < ApplicationRecord
  belongs_to :product_category
  belongs_to :vendor
  has_many_attached :product_image
  has_many :comments, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products
  has_many :users, through: :comments

end
