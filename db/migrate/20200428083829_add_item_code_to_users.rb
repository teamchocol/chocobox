class AddItemCodeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :item_code, :string
  end
end
