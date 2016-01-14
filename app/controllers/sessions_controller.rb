class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id

      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to dashboard_path
      end
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
