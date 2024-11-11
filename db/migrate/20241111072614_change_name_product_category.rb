class ChangeNameProductCategory < ActiveRecord::Migration[7.2]
  def change
    rename_column :product_categories, :Name, :name
  end
end
