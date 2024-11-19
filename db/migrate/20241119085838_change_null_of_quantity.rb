class ChangeNullOfQuantity < ActiveRecord::Migration[7.2]
  def change
    change_column_null :order_products, :quantity, false
  end
end
