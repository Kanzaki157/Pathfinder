class UserNotificationsController < ApplicationController
  before_action :authenticate_user! # ログインユーザーのみ通知を見ることができるようにします
  def index
    @notifications = current_user.user_notifications
  end
  
  def destroy
    notification = UserNotification.find(params[:id])
    notification.destroy if notification.user == current_user
    redirect_to root_path, notice: '通知が削除されました。'
  end
  
end
