class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user = current_user
      user.confirmed_at = Time.now
      # Confirmable を使用している場合は必要
    end
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  # ページネーションの表示件数追加
  paginates_per 6

  # フォローフォロワー関係
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :follower, source: :followed
  has_many :followers, through: :followed, source: :follower

  # 口コミ投稿との関連付け
  has_many :comments, dependent: :destroy

  # お問い合わせとの関連付け
  has_many :contacts, dependent: :destroy

  # いいね機能関連付け
  has_many :favorites, dependent: :destroy

  # 画像投稿
  has_one_attached :profile_image

  # お気に入り登録判定
  def favorited_by?(item_code)
    favorites.find_by(item_code: item_code)
  end

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

  # 検索機能
  def self.search(search, word)
    if search == "forward_match"
      @user = User.where("(name || nickname) LIKE?", word)
    elsif search == "backward_match"
      @user = User.where("(name || nickname) LIKE?", word)
    elsif search == "perfect_match"
      @user = User.where("(name || nickname) LIKE?", word)
    elsif search == "partial_match"
      @user = User.where("(name || nickname) LIKE?", word)
    else
      @user = User.all
    end
  end

  # ユーザー登録用
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :nickname, presence: true, length: { maximum: 20, minimum: 2 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  # validates :email, presence: true, length: {maximum: 255},
  #                   format: {with: VALID_EMAIL_REGEX},
  #                   uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :introduction, length: { maximum: 100 }
end
