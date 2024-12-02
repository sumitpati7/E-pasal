# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OrderSerializer < ActiveModel::Serializer
    attributes :id
    has_many :order_products, serializer: OrderProductSerializer
end
