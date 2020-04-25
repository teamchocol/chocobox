class AddHealthyToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :healthy, :float
  end
end
