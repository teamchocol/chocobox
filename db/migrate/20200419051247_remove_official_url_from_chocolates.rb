class RemoveOfficialUrlFromChocolates < ActiveRecord::Migration[5.2]
  def change
    remove_column :chocolates, :image_url, :string
  end
end
