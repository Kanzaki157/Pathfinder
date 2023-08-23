class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :event, optional: true
  validates :notification_type, presence: true
end
