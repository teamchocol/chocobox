class AddColumnsToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :item_code, :string
  end
end
