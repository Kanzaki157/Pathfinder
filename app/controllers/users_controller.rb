class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :join_event, :leave_event]
  before_action :authenticate_user!, except: [:index, :new, :create]
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def index
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
  end
  
  def show
    @user = User.find(params[:id])
    @user_events = @user.events # ユーザーが作成したイベントを取得
    
    @user = User.find(params[:id])
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'ユーザーが正常に作成されました。'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザーは正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'ユーザーは正常に破棄されました。'
  end
  
  def join_event
    event = Event.find(params[:event_id])
    unless @user.events.include?(event)
      @user.events << event
      redirect_to event, notice: 'イベントに参加しました。'
    else
      redirect_to event, notice: 'すでにこのイベントに参加しています。'
    end
  end
  
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.js
    end
  end
  
  def update_icon
    @user = User.find(params[:id])
    if @user.update(user_icon_params)
      redirect_to user_path(@user), notice: "アイコンを更新しました。"
    else
      render :show
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
    
    # 信頼できるパラメータのリストのみを許可します。
    def user_params
      params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :password, :address, :post_code, :phone_number, :is_delete, :image)
    end
    
    def user_icon_params
      params.require(:user).permit(:image)
    end
    
end