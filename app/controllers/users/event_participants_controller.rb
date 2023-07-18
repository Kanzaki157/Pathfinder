class EventParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  
  # イベントに参加するためのアクション
  def create
    # current_userがイベントの参加者でなければ参加者を追加します。
    if @event.users.include?(current_user)
      flash[:alert] = "あなたはすでにこのイベントに参加しています"
    else
      @event.users << current_user
      flash[:notice] = "イベントに正常に参加しました。"
    end
    redirect_to @event
  end
  
  # イベントから退出するためのアクション
  def destroy
    # current_userがイベントの参加者であれば参加者から削除します。
    @event.users.delete(current_user)
    flash[:notice] = "イベントから退出しました。"
    redirect_to @event
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
