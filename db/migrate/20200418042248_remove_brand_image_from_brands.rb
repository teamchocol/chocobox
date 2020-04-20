class RemoveBrandImageFromBrands < ActiveRecord::Migration[5.2]
  def change
    remove_column :brands, :brand_image, :string
  end
end
