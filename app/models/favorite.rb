class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :chocolate
  validates :user_id, presence: true
  validates :chocolate_id, presence: true


end
