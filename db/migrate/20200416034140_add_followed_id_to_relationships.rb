class AddFollowedIdToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :followed_id, :bigint
    add_column :relationships, :follower_id, :bigint
  end
end
