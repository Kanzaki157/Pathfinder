# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # updateとdestroyアクションが実行される前にensure_normal_userメソッドを呼び出します。
  before_action :ensure_normal_user, only: %i[update destroy]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end
  
  # ensure_normal_userメソッド
  # ユーザーがゲストユーザーの場合（メールアドレスが'guest@example.com'の場合）、
  # ユーザーを編集・削除できないようにします。ユーザーをルートパスにリダイレクトし、
  # アラートメッセージを表示します。
  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除・編集できません。'
    end
  end
  
  
  
  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  
   # 新規登録後のリダイレクト先をユーザーの詳細ページに設定します。
  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  # The path used after sign up for inactive accounts.
  
  # 新規登録後、アカウントが非活性の場合のリダイレクト先を新規登録ページに設定します。
  def after_inactive_sign_up_path_for(resource)
    new_user_registration_path
  end
end
