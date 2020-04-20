class RemoveBrandAmazonNameFromChocolates < ActiveRecord::Migration[5.2]
  def change
    remove_column :chocolates, :brand_amazon_name, :string
  end
end
