class UserNotificationsController < ApplicationController
  before_action :authenticate_user! # ログインユーザーのみ通知を見ることができるようにします
  
  def index
    @notifications = current_user.user_notifications
  end
  
end
