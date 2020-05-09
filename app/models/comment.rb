class Comment < ApplicationRecord
  # ユーザーとの関連付け
  belongs_to :user
  attachment :image, destroy: false

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


  # validates :title, presence: true, length: {maximum: 50}
  
  # with_options presence: true do
  #   validates :taste
  #   validates :healthy
  #   validates :cost_performance
  
  # with_options numericality: {
  #   less_than_or_equal_to: 5,
  #   greater_than_or_equal_to: 1
  # }  do
  #   validates :taste
  #   validates :healthy
  #   validates :cost_performance
  
  # validates :content, presence: true
  # validates :content, length: {maximum: 300}
  # validates :user_id, uniqueness: {scope: [:chocolate_id]}

  # 画像サイズ
  # validate :image_size

  private
  # アップロードされた画像のサイズをバリデーションする
  # def picture_size
  #   errors.add(:image, 'ファイルサイズを5MBより小さくしてください') if image.size > 5.megabytes
  # end
end
