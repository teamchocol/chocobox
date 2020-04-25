class AddTasteToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :taste, :float
  end
end
