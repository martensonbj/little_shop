class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_user
  helper_method :current_admin?
  helper_method :current_artist?
  helper_method :artist_owns_item?

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

  def artist_owns_item?(item)
    item.user.id == current_user.id
  end

  def sanitize_price(price)
    price.to_s.gsub!(/[,$]/, "").to_i
  end
end
