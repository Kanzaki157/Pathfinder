class EventsController < ApplicationController
  # 特定のアクションを実行する前に、対象のイベントを設定
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # 全てのイベントを取得
  def index
    @events = Event.all
  end
  
  # 特定のイベントを表示（set_eventが先に実行される）
  def show
  end

  # 新しいイベントのインスタンスを作成
  def new
    @event = Event.new
  end

  # 特定のイベントを編集（set_eventが先に実行される）
  def edit
  end

  # ログイン中のユーザーの新しいイベントを作成し、保存
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      puts @event.errors.full_messages
      render :new
    end
  end

  # 特定のイベントを更新（set_eventが先に実行される）
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # 特定のイベントを削除（set_eventが先に実行される）
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  # params[:id]で指定されたイベントを設定
  def set_event
    @event = Event.find(params[:id])
  end
  
  # フォームから受け取るパラメータを制限
  def event_params
  params.require(:event).permit(:user_id, :name, :location, :closed_on, :representative, :fax_number, :opening_hours, :main_products, :price, :access_info, :website_url, :google_map_url, :contact_info, :reservation_info, :status_based_on_count, :phone_number, :description, :max_participants, :start_time, :end_time)
  end
end
