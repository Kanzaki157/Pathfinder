class EventsController < ApplicationController
  # 特定のアクションを実行する前に、対象のイベントを設定
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # 全てのイベントを取得
  def index
    @events = Event.all
    @event = Event.new
  end
  
  # 特定のイベントを表示（set_eventが先に実行される）
  def show
    @user = @event.organizer # イベントの主催者を取得
    @organizer = @event.organizer # イベントの主催者を取得
    # @participants = @event.participants.filter{|user| user.email != "guest@example.com"} # イベントの参加者を取得
    @participants = @event.participants
  end

  # 新しいイベントのインスタンスを作成
  def new
    @event = Event.new
  end
  
  # def confirm
  #   @event = Event.new(event_params)
  #   @event.user_id = current_user.id
  #   if @event.valid?
  #     session[:event] = event_params # 入力情報が有効であればセッションに保存
  #   else
  #     render :new # 入力情報が無効であればフォーム画面に戻る
  #   end
  # end
  
  def join
    @event = Event.find(params[:id]) # パラメータからイベントを見つけます
    if @event.participants.include?(current_user)
      # ユーザーが既にイベントに参加している場合、メッセージを表示
      flash[:alert] = "あなたはすでにこのイベントに参加しています。"
    else
      # ユーザーをイベントの参加者として追加
      @event.participants << current_user
    end
    redirect_to @event # イベントの詳細ページにリダイレクト
  end
  
  def leave
    event = Event.find(params[:id])
    event.participants.delete(current_user)
    redirect_to event_path(event)
  end


  
  def cancel
  @event = Event.find(params[:id])
    if @event.organizer == current_user
      @event.destroy
      redirect_to root_path, notice: 'イベントがキャンセルされました'
    else
      redirect_to @event, alert: 'あなたはこのイベントをキャンセルする権限がありません'
    end
  end
  
  # 特定のイベントを編集（set_eventが先に実行される）
  def edit
    @event = Event.find(params[:id])
  end
  
  def remove_participant
    @event = Event.find(params[:id])
    @user = User.find(params[:user_id])
    
    if @event.organizer == current_user
      @event.participants.delete(@user)
      redirect_to @event, notice: '参加者が削除されました。'
    else
      redirect_to @event, alert: 'あなたはこのイベントから参加者を削除する権限がありません。'
    end
  end
  
  # ログイン中のユーザーの新しいイベントを作成し、保存
  def create
    @event = current_user.events.build(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to @event, notice: 'イベントが正常に作成されました。'
    else
      if user_signed_in?
        @user = current_user
        @followed_users = @user.following_users
        @notifications = current_user.user_notifications
      else
        @user = nil
        @followed_users = []
        @notifications = []
      end
      @users = User.all
      @event = Event.new
      # 取得したイベントを「いいね」の数で並び替え、上位10件を取得する
      @popular_events = Event.left_joins(:event_favorites).group(:id).order('COUNT(event_favorites.id) DESC').limit(10)
      # イベントを作成日時の降順に並び替え、上位10件を取得する
      @latest_events = Event.order(created_at: :desc).limit(10)
      categories = ['お祭り', '体験', '出会い', 'その他']
      @categories_events = {}
      categories.each do |category|
      @categories_events[category] = Event.where(category: category).order(created_at: :desc).limit(10)
    end
      render "users/index"
    end
  end

  # 特定のイベントを更新（set_eventが先に実行される）
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'イベントは正常に更新されました'
    else
      render :edit
    end
  end

  # 特定のイベントを削除（set_eventが先に実行される）
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'イベントは正常に削除されました'
  end

  private
  
  # params[:id]で指定されたイベントを設定
  def set_event
    @event = Event.find(params[:id])
  end
  
  # フォームから受け取るパラメータを制限
  def event_params
  params.require(:event).permit(:user_id, :name, :location, :closed_on, :representative, :fax_number, :opening_hours, :main_products, :price, :access_info, :website_url, :google_map_url, :contact_info, :reservation_info, :status_based_on_count, :phone_number, :description, :max_participants, :start_time, :end_time, :category, :image)
  end
end
