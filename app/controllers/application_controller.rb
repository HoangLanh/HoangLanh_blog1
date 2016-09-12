class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?  

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up do |u|
      u.permit :name, :email, :password, :password_confirmation,
        :remember_me, :role
    end
    devise_parameter_sanitizer.permit :account_update do |u|
      u.permit :name, :email, :password, :password_confirmation,
        :current_password, :phone_number, :address, :avatar
    end
  end
end
