class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.text :description
      t.string :price
      t.references :product_category, null: false, foreign_key: true
      t.integer :stock
      t.integer :discount_percentage

      t.timestamps
    end
  end
end
