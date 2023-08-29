class Event < ApplicationRecord
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
  validates :representative, presence: { message: "企画名または企業名が空白です" }
  validates :category, presence: { message: "カテゴリが空白です" }
  validates :location, presence: { message: "開催地が空白です" }
  validates :name, presence: { message: "代表者名が空白です" }
  validates :start_time, presence: { message: "開始日時が空白です" }
  validates :end_time, presence: { message: "終了日時が空白です" }
  validates :main_products, presence: { message: "主要商品が空白です" }
  validates :max_participants, presence: { message: "上限人数が空白です" }
  validates :description, presence: { message: "詳細な説明が空白です" }
end
