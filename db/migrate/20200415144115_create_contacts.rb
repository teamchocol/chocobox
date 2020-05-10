class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string:title
      t.text:content
      t.bigint:user_id
      t.string:name
      t.string:email
      t.timestamps
    end
  end
end
