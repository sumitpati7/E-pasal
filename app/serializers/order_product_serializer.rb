class OrderProductSerializer < ActiveModel::Serializer
    attributes :id, :quantity, :status
    belongs_to :products
end
