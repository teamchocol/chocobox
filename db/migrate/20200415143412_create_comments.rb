class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string:title
      t.text:content
      t.bigint:user_id
      t.string:image_id
      t.bigint:chocolate_id
      t.float:rate
      t.float:taste
      t.float:healthy
      t.float:cost_performance
      t.string:item_code
      t.timestamps
    end
  end
end
