class RelationshipsController < ApplicationController
  # ログインしていないユーザーがこのコントローラのアクションにアクセスしようとすると、ログインページにリダイレクトされます。
  before_action :authenticate_user!
  
  def create
    followed_user = User.find(params[:user_id])
    current_user.follow(followed_user.id)
    notification = followed_user.user_notifications.build(notification_type: 'こんにちは', user: current_user)
    if notification.save
    # 保存が成功したときの処理
    # flash[:success] = 'フォローしました。通知も送信されました。'
    else
    # 保存が失敗したときの処理
    flash[:alert] = 'フォローは成功しましたが、通知の送信に失敗しました。'
    end
    redirect_to request.referer
  end

  
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  
end
