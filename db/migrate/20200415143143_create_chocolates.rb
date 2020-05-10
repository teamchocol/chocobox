class CreateChocolates < ActiveRecord::Migration[5.2]
  def change
    create_table :chocolates do |t|
      t.string:name 
      t.text:url
      t.string:asin
      t.integer:price
      t.string:brand_id
      t.integer:taste
      t.integer:healthy
      t.integer:cost_performance
      t.text:content
      t.string:chocolate_image_id
      t.string:rakuten_chocolate_name_url
      t.string:medium_image_url
      t.integer:user_id
      t.timestamps
    end
  end
end
