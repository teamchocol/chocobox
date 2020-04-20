class AddBrandImageIdToBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :brand_image_id, :string
  end
end
