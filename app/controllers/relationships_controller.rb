class RelationshipsController < ApplicationController
  # ログインしていないユーザーがこのコントローラのアクションにアクセスしようとすると、ログインページにリダイレクトされます。
  before_action :authenticate_user!
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  
end
