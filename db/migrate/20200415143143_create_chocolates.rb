class CreateChocolates < ActiveRecord::Migration[5.2]
  def change
    create_table :chocolates do |t|
      t.string:name 
      t.text:url
      t.string:image_url
      t.string:asin
      t.integer:price
      t.string:brand_amazon_name
      t.text:official_url
      t.string:brand_id
      t.integer:taste
      t.integer:healthy
      t.integer:cost_performance
      t.timestamps
    end
  end
end
