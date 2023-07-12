class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :vendor_favorites
  has_many :favorited_vendors, through: :vendor_favorites, source: :vendor
  
  has_many :event_favorites
  has_many :favorited_events, through: :event_favorites, source: :event

         
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64

      user.last_name = 'Guest'  # 値を設定する
      user.first_name = 'User'  # 必要であれば他のフィールドも
       user.last_name_kana = 'ゲスト'  # last_name_kanaに対しても値を設定
      user.first_name_kana = 'ユーザー' # first_name_kanaに対しても値を設定
      user.address = '123 Guest Street'
      user.post_code = '1234567'  # post_codeに対しても値を設定
      user.phone_number = '09012345678'  # phone_numberに対しても値を設定
      # 必要に応じて他の属性を設定する
    end
  end
end
