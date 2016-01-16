class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    if current_user
      @user = current_user
    else
      render file: "public/404"
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    if @user.update_attributes(user_params)
      if current_user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to dashboard_path
      end
    else
      render :edit
      flash.now[:error] = "Incorrect user information"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :username,
                                 :password,
                                 :password_confirmation,
                                 :email_address,
                                 :street_address,
                                 :city,
                                 :state,
                                 :zipcode)
  end
end
