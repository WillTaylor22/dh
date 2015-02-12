class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username,
      :email, :password, :password_confirmation, :remember_me, :photo) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, 
        :email, :password, :password_confirmation, :current_password,
        :first_name, :last_name, :summary, :long_description, :postcode,
        :photo, :crop_x, :crop_y, :crop_w, :crop_h, :phone_number, :category,
        :activity_level, :valid_license,
        :category_id, day_ids: [], shiftslot_ids: []) }
  end

end
