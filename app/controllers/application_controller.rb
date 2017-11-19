class ApplicationController < ActionController::Base
  protect_from_forgery if: :json_request # return null session when API call
  protect_from_forgery with: :exception, unless: :json_request
  # before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def json_request
    request.format.json?
  end

  # protected
  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :authentication_token) }
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
  # end
end
