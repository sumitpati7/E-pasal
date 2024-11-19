class AddDefaultValueToStatus < ActiveRecord::Migration[7.2]
  def change
    change_column_default :order_products, :status, "pending"
    change_column_null :order_products, :status, false
  end
end
