class UserNotificationsController < ApplicationController
  before_action :authenticate_user! # ログインユーザーのみ通知を見ることができるようにします
  def index
    @notifications = current_user.user_notifications
  end
  
  def destroy
    notification = current_user.user_notifications.find_by(id: params[:id])
    if notification
      notification.destroy
      redirect_to root_path, notice: '通知が削除されました。'
    else
      redirect_to root_path, alert: '通知が見つかりませんでした。'
    end
  end

  
end
