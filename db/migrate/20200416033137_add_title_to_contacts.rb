class AddTitleToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :title, :string
    add_column :contacts, :content, :text
    add_column :contacts, :user_id, :bigint
    add_column :contacts, :name, :string
    add_column :contacts, :email, :string
  end
end
