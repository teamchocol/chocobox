class AddRakutenChocolateNameUrlToChocolates < ActiveRecord::Migration[5.2]
  def change
    add_column :chocolates, :rakuten_chocolate_name_url, :string
  end
end
