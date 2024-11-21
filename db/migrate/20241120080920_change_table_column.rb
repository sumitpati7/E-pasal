class ChangeTableColumn < ActiveRecord::Migration[7.2]
  def change
    rename_column :products, :name, :title
  end
end
