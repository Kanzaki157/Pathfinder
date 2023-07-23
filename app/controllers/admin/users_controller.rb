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
  
  private
  
  def admin_only
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You must be an admin to do that."
    end
  end
end
