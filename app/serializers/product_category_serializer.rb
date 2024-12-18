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
class ProductCategorySerializer < ActiveModel::Serializer
    attributes :id, :name, :icon
    has_many :products, serializer: ProductSerializer
  end
