class ChangeContactPhoneToUsers < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :contact_phone, :string
  end
end
