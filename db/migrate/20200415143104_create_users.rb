class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string:name 
      t.string:email
      t.string:password_digest
      t.string:nickname
      t.integer:age
      t.string:gender
      t.string:comment
      t.string:job
      t.boolean:admin
      t.string:profile_image
      t.timestamps
    end
  end
end
