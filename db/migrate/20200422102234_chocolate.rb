class Chocolate < ActiveRecord::Migration[5.2]
  def change
    add_column :chocolates, :user_id, :integer
  end
end
