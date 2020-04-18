class RemoveImageFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :image, :string
  end
end
