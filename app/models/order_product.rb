# == Schema Information
#
# Table name: order_products
#
#  id         :bigint           not null, primary key
#  order_id   :bigint           not null
#  product_id :bigint           not null
#  quantity   :integer          not null
#  status     :string           default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  after_create_commit -> { broadcast_append_to "orders", partial: "shared/orderProduct", locals: { orderProduct: self }, target: "orders" }
  after_update_commit -> { broadcast_replace_to "orders", partial: "shared/orderProduct", locals: { orderProduct: self } }
  after_destroy_commit -> { broadcast_remove_to "orders" }

  enum status: { pending: "pending", on_the_way: "on the way", shipped: "shipped", cancled: "cancled" }
end
