class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string:name
      t.text:content
      t.string:brand_image_id 
      t.timestamps
    end
  end
end
