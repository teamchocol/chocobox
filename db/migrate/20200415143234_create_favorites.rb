class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.bigint:user_id
      t.bigint:chocolate_id
      t.string:item_code
      t.timestamps
    end
  end
end
