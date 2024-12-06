# == Schema Information
#
# Table name: product_categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  icon       :string
#
class ProductCategory < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  after_create_commit -> { broadcast_append_to "category", partial: "shared/category_name", locals: { category: self }, target: "category" }
end
# after_update_commit -> { broadcast_replace_to "products", partial: "shared/product", locals: { product: self } }
# after_destroy_commit -> { broadcast_remove_to "products" }
