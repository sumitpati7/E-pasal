class AddVendorIdToProduct < ActiveRecord::Migration[7.2]
  def change
    add_reference :products, :vendor, null: false, foreign_key: true
  end
end
