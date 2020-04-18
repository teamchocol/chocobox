class AddContentToChocolates < ActiveRecord::Migration[5.2]
  def change
    add_column :chocolates, :content, :text
  end
end
