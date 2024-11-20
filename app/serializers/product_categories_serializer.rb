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
class ProductCategoriesSerializer < ActiveModel::Serializer
  attributes :id, :name, :icon
end
