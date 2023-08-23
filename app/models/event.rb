class Event < ApplicationRecord
  # def google_calendar_url
  #   base_url = "https://www.google.com/calendar/render?action=TEMPLATE"
  #   text = "&text=#{URI.encode(name)}"
  #   dates = "&dates=#{start_date.strftime('%Y%m%dT%H%M%SZ')}/#{end_date.strftime('%Y%m%dT%H%M%SZ')}"
  #   details = "&details=#{URI.encode(details)}"
  #   location = "&location=#{URI.encode(location)}"
  #   "#{base_url}#{text}#{dates}#{details}#{location}"
  # end
  has_one_attached :image
  # Event は User モデルと関連づけられています。ここでは User を 'organizer' として扱っており、
  # 外部キーとして 'user_id' を使用しています。これにより、各イベントはユーザ（開催者）に所属していると扱われます。
  belongs_to :organizer, class_name: "User", foreign_key: "user_id"
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  
  # Event は EventParticipant モデルと関連づけられています。ここでは、EventParticipant という中間テーブルを使って、
  # User モデルと多対多の関連を組んでいます。dependent: :destroy を設定することで、イベントが削除されたときに、
  # 関連する EventParticipant も自動的に削除されます。
  has_many :event_participants, dependent: :destroy
  
  # Event は EventFavorite モデルと関連づけられています。EventFavorite モデルを介して、ユーザが
  # どのイベントを「お気に入り」に追加したかを管理します。
  has_many :event_favorites, dependent: :destroy
  
  # Event は User モデルと関連づけられています。ここでは、User を 'participants' として扱っており、
  # 中間テーブルとして EventParticipant を使用しています。これにより、各イベントは多数の参加者（ユーザ）を持つことができます。
  has_many :participants, through: :event_participants, source: :user
  
  def cancel
    self.update(cancelled: true)
  end
  
  # イベントが作成された後、notify_followersメソッドを呼び出す
  after_create :notify_followers

  # notify_followersメソッドの定義
  def notify_followers
    # イベント作成者のフォロワーを一人ずつ処理する
    self.organizer.follower_users.each do |follower|
      # 各フォロワーに対して、通知を作成する
      UserNotification.create!(
        user: follower, # 通知を受け取るユーザー
        event: self,    # 通知に関連するイベント
        notification_type: 'new_event', # 通知のタイプ（ここでは新しいイベントを示す文字列）
      )
    end
  end
  
  # バリデーション
  validates :representative, presence: true  # 企業名または企画名が存在すること
  validates :location, presence: true  # 開催地が存在すること
  validates :end_time, presence: true  # 主要商品が存在すること
  validates :start_time, presence: true
  validates :category, presence: true
  validates :name, presence: true
  validates :main_products, presence: true
  validates :description, presence: true
end
