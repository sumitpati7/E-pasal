class ChangeDafaultInProduct < ActiveRecord::Migration[7.2]
  def change
    change_column_null :products, :name, false
    change_column_null :products, :stock, false
    change_column_null :products, :brand, false
    change_column_null :products, :discount_percentage, false
    change_column_null :products, :price, false
    change_column_default :products, :brand, "No Brand"
    change_column_default :products, :discount_percentage, 0
  end
end
