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

  after_create_commit -> { broadcast_append_to "products", partial: "shared/product", locals: { product: self }, target: "products" }
  after_update_commit -> { broadcast_replace_to "products", partial: "shared/product", locals: { product: self } }
  after_destroy_commit -> { broadcast_remove_to "products" }

  def image_urls
    if image_url.nil?
      product_image.map { |image| "http://localhost:3001"+Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) }
    else
      image_url
    end
  end
end
