class AddNameToChocolates < ActiveRecord::Migration[5.2]
  def change
    add_column :chocolates, :name, :string
    add_column :chocolates, :url, :text
    add_column :chocolates, :image_url, :string
    add_column :chocolates, :asin, :string
    add_column :chocolates, :price, :integer
    add_column :chocolates, :brand_amazon_name, :string
    add_column :chocolates, :official_url, :text
    add_column :chocolates, :brand_id, :string
    add_column :chocolates, :taste, :integer
    add_column :chocolates, :healthy, :integer
    add_column :chocolates, :cost_performance, :integer
  end
end
