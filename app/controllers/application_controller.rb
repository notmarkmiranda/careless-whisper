class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_user

  def redirect_if_logged_in
    redirect_to dashboard_path if current_user.present?
  end

  def authenticate_user!
    redirect_to new_user_path unless current_user.present?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end
end
