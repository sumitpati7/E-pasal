class AddColumnsToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :text
    add_column :users, :contact_phone, :text
  end
end
