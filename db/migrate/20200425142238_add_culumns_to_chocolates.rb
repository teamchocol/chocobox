class AddCulumnsToChocolates < ActiveRecord::Migration[5.2]
  def change
    add_column :chocolates, :code, :string
  end
end
