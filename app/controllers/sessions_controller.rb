class SessionsController < ActionController::Base
  def destroy
    session.clear
    redirect_to "/"
  end
end
