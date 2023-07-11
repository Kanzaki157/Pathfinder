class UserNotificationsController < ApplicationController
  before_action :set_user_notification, only: [:destroy]

  def create
    @user_notification = UserNotification.new(user_notification_params)
    if @user_notification.save
      redirect_to users_path, notice: 'Notification was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @user_notification.destroy
    redirect_to users_path, notice: 'Notification was successfully destroyed.'
  end

  private
    def set_user_notification
      @user_notification = UserNotification.find(params[:id])
    end

    def user_notification_params
      params.require(:user_notification).permit(:user_id, :vendor_id, :notification_type, :read_status)
    end
end
