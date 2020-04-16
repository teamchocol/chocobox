class AddNameToBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :name, :string
    add_column :brands, :content, :text
    add_column :brands, :image, :string
  end
end
