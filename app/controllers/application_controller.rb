class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    root_path  # ログイン後にリダイレクトするパス
  end
  
  def after_sign_out_path_for(resource_or_scope)
    root_path  # ログアウト後にリダイレクトするパス
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :address, :post_code, :phone_number ])
  end
end