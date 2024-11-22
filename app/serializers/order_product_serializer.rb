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
        discounted_price: object.product.discounted_price,
        discount_percentage: object.product.discount_percentage
        }
    end
end
