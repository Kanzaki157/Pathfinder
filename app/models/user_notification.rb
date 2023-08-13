class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :event, optional: true # イベントへの参照を追加
  validates :notification_type, presence: true
end
