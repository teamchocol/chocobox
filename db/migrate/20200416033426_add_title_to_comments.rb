class AddTitleToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :title, :string
    add_column :comments, :content, :text
    add_column :comments, :user_id, :bigint
    add_column :comments, :image, :string
    add_column :comments, :chocolate_id, :bigint
  end
end
