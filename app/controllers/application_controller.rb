class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  
  # Whitelist following form fields so that they can be processed if coming from Devise signup form
  before_action :configure_permitted_perameters, if: :devise_controller?
  protected
    def configure_permitted_perameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation) }
    end
end
