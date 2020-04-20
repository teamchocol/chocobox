class AddBrandImageToBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :brand_image, :string
  end
end
