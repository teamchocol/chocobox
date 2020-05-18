class Comment < ApplicationRecord
  # ユーザーとの関連付け
  belongs_to :user
  attr_accessor :x, :y, :width, :height
  attachment :image
 


  def self.search(search,word)
   
		if search == "forward_match"
						@comment = Comment.where("(title)  LIKE?","#{word}%")
		elsif search == "backward_match"
						@comment = Comment.where("(title) LIKE?","%#{word}")
		elsif search == "perfect_match"
						@comment = Comment.where("#{word}")
		elsif search == "partial_match"
						@comment = Comment.where("(title) LIKE?","%#{word}%")
		else
						@comment = Comment.all
    end
    
  end


  # ページネーションの表示件数追加
  # paginates_per 10


  validates :title, presence: true, length: {maximum: 50}
  validates :taste, 
  numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }  
  validates :healthy, 
  numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }  
  validates :cost_performance, 
  numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }  
  
  validates :content, presence: true
  validates :content, length: {maximum: 300}
 
end
