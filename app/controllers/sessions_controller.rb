class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      account_link = "#{view_context.link_to('Create new account?',
                                              new_user_path)}"
      flash[:error] = "Invalid login credentials. #{account_link}"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to "/"
  end
end
