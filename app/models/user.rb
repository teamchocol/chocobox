class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  
def self.guest
  find_or_create_by!(email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    user.user = current_user
    # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
  end
end

def self.find_for_oauth(auth)
  user = User.where(uid: auth.uid, provider: auth.provider).first

  unless user
    user = User.create(
      uid:      auth.uid,
      provider: auth.provider,
      email:    auth.info.email,
      password: Devise.friendly_token[0, 20]
    )
  end
  user
end
  # ユーザー登録用
  # before_save { email.downcase! }
  # validates :name, presence: true, length: {maximum: 50}
  # validates :nickname, presence: true, length: {maximum: 50}
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  # validates :email, presence: true, length: {maximum: 255},
  #                   format: {with: VALID_EMAIL_REGEX},
  #                   uniqueness: {case_sensitive: false}
  # validates :password, length: {minimum: 6}, allow_nil: true
  # validates :comment, length: {maximum: 100}
  

  # ページネーションの表示件数追加
  # paginates_per 9

  # 口コミ投稿との関連付け
  has_many :comments, dependent: :destroy

  # お問い合わせとの関連付け
  has_many :contacts, dependent: :destroy

  # お気に入り機能追加用中間テーブル追加
  has_many :favorites, dependent: :destroy
  has_many :chocolates, dependent: :destroy

  attachment :profile_image, destroy: false

   # ユーザーをフォローする関数
   def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーをフォロー解除する関数
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしているかを調べる関数
  def following?(user)
    following.include?(user)
  end

  def self.search(search,word)
		if search == "forward_match"
						@user = User.where("name LIKE?","#{word}%")
		elsif search == "backward_match"
						@user = User.where("name LIKE?","%#{word}")
		elsif search == "perfect_match"
						@user = User.where("#{word}")
		elsif search == "partial_match"
						@user = User.where("name LIKE?","%#{word}%")
		else
						@user = User.all
		end
  end
 
  # has_many :active_relationships, class_name:  "Relationship",
  # foreign_key: "follower_id",
  # dependent:   :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得

  has_many :following, through: :follower, source: :followed
  
  has_many :followers, through: :followed, source: :follower
  
 def self.without_sns_data(auth)
  user = User.where(email: auth.info.email).first

    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user ,sns: sns}
  end

  def self.with_sns_data(auth, snscredential)
  user = User.where(id: snscredential.user_id).first
  unless user.present?
    user = User.new(
      nickname: auth.info.name,
      email: auth.info.email,
    )
  end
  return {user: user}
  end

  def self.find_oauth(auth)
  uid = auth.uid
  provider = auth.provider
  snscredential = SnsCredential.where(uid: uid, provider: provider).first
  if snscredential.present?
    user = with_sns_data(auth, snscredential)[:user]
    sns = snscredential
  else
    user = without_sns_data(auth)[:user]
    sns = without_sns_data(auth)[:sns]
  end
  return { user: user ,sns: sns}
  end
end
