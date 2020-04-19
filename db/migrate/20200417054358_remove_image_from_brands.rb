class RemoveImageFromBrands < ActiveRecord::Migration[5.2]
  def change
    remove_column :brands, :image, :string
  end
end
