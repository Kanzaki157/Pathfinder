class Admin::UsersController < ApplicationController
  before_action :admin_only
  
  def index
    @users = User.all
  end
  
  def toggle_active
    user = User.find(params[:id])
    user.update(active: !user.active)
    redirect_to admin_users_path
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: 'ユーザーは正常に削除されました。'
  end
  
  private
  
  def admin_only
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "それを行うには管理者である必要があります。"
    end
  end
end
