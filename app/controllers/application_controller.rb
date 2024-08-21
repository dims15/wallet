class ApplicationController < ActionController::Base
  before_action :set_locale
  helper_method :current_user, :logged_in?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_user
    @current_user ||= Customer.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'You must log in to access this page'
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
