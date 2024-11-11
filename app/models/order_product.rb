# == Schema Information
#
# Table name: order_products
#
#  id         :bigint           not null, primary key
#  order_id   :bigint           not null
#  product_id :bigint           not null
#  quantity   :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
end
