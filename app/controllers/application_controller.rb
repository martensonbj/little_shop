class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_user
  helper_method :current_admin?
  helper_method :current_artist?

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_artist?
    current_user && current_user.artist?
  end
end
