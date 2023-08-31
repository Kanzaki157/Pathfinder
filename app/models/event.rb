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

  def notify_followers
    count = 0
    
    self.organizer.follower_users.each do |follower|
      unless follower == self.organizer
        UserNotification.create!(
          user: follower,
          event: self,
          notification_type: 'new_event'
        )
        count += 1
      end
    end
  
    UserNotification.create!(
      user: self.organizer,
      event: self,
      notification_type: 'new_event'
    )
    count += 1
  
    Rails.logger.info "Total notifications sent for the event #{self.id}: #{count}"
  end


  # バリデーション
  validates :representative, presence: true
  validates :name, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :main_products, presence: true
  validates :max_participants, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
end
