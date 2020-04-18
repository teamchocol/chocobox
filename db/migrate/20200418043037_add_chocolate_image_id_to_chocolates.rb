class AddChocolateImageIdToChocolates < ActiveRecord::Migration[5.2]
  def change
    add_column :chocolates, :chocolate_image_id, :string
  end
end
