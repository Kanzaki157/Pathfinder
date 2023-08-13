class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # deviseのモジュールをインクルードしています。
  # :database_authenticatable はパスワードのハッシュ化を行う。
  # :registerable はユーザー登録や削除、編集などを可能にする。
  # :recoverable はパスワードのリセットと再設定のための通知を行う。
  # :rememberable はクッキーからユーザーを記憶するためのトークンを管理する。
  # :validatable はメールとパスワードのバリデーションを提供する。
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :image
  
  # ユーザーが参加するイベントを管理します。
  has_many :event_favorites
  has_many :favorited_events, through: :event_favorites, source: :event
  
  # ユーザーが参加するイベントを管理します。
  has_many :event_participants
  has_many :events, through: :event_participants
  
  # フォローをした、されたの関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower
  
  has_many :user_notifications
  
  # ゲストユーザーを作成または検索します。
  # ゲストメールアドレスがすでに存在する場合はそのユーザーを返し、
  # 存在しない場合は新たにゲストユーザーを作成します。
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64 # パスワードはランダムに生成

      user.last_name = 'Guest'  # 値を設定する
      user.first_name = 'User'  # 必要であれば他のフィールドも
       user.last_name_kana = 'ゲスト'  # last_name_kanaに対しても値を設定
      user.first_name_kana = 'ユーザー' # first_name_kanaに対しても値を設定
      user.address = '123 Guest Street'
      user.post_code = '1234567'  # post_codeに対しても値を設定
      user.phone_number = '09012345678'  # phone_numberに対しても値を設定
    end
  end
  
  def already_favorited?(event)
    self.favorited_events.include?(event)
  end

  
  #　フォローしたときの処理
  def follow(user_id)
    followers.create(followed_id: user_id)
  end
  
  #　フォローを外すときの処理
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end
  
  #フォローしていればtrueを返す
  def following?(user)
    following_users.include?(user)
  end	
  
end
