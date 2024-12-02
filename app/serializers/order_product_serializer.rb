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
class OrderProductSerializer < ActiveModel::Serializer
    attributes :id, :quantity, :status, :product
    belongs_to :product

    def product
        return nil unless object.product
        {
        id: object.product.id,
        name: object.product.title,
        price: object.product.price,
        image: object.product.image,
        discount_percentage: object.product.discount_percentage
        }
    end
end
