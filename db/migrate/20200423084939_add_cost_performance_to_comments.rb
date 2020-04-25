class AddCostPerformanceToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :cost_performance, :float
  end
end
