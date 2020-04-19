class AddMediumImageUrlToChocolates < ActiveRecord::Migration[5.2]
  def change
    add_column :chocolates, :medium_image_url, :string
  end
end
