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

  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than: 100 }, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 1 }, presence: true
  validates :name, :brand, :description, :price, :product_category_id, :vendor_id, presence: true

  after_create_commit -> { broadcast_append_to "products", partial: 'shared/product', locals: { product: self }, target: "products"}
  after_update_commit -> { broadcast_replace_to "products", partial: 'shared/product', locals: { product: self }}
  after_destroy_commit -> { broadcast_remove_to "products"}
end
