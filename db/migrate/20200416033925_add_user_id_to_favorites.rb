class AddUserIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :user_id, :bigint
    add_column :favorites, :chocolate_id, :bigint
  end
end
