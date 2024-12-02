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

  after_create_commit -> { broadcast_prepend_to "orders", partial: "shared/orderProduct", locals: { orderProduct: self }, target: "orders" }
  after_update_commit -> { broadcast_replace_to "orders", partial: "shared/orderProduct", locals: { orderProduct: self } }
  after_destroy_commit -> { broadcast_remove_to "orders" }

  enum status: { pending: "pending", on_the_way: "on the way", shipped: "shipped", cancelled: "cancelled" }

  after_update :delete_if_shipped_or_cancelled
  after_destroy :destroy_parent_order_if_empty

  validates :order_id, :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0 }, presence: true
  private

  def delete_if_shipped_or_cancelled
    destroy if saved_change_to_status? && shipped? || cancelled?
  end

  def destroy_parent_order_if_empty
    order.destroy if order.order_products.empty?
  end
end
