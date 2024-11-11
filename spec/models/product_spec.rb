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
require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
