class AddIconToProductCategory < ActiveRecord::Migration[7.2]
  def change
    add_column :product_categories, :icon, :string
  end
end
