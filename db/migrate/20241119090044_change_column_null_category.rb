class ChangeColumnNullCategory < ActiveRecord::Migration[7.2]
  def change
    change_column_null :product_categories, :name, false
  end
end
