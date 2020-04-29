class RemoveColumnsFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :chocolate_id, :integer
  end
end
