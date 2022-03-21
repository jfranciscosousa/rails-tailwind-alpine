class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    if current_user
      redirect_to(root_path)

      return
    end

    @user = User.new
  end

  def create
    @user = User.new(user_params)
    logged_in = login(user_params[:email], user_params[:password], true)

    if logged_in
      redirect_back_or_to root_path, notice: "Login successful"
    else
      flash.now[:alert] = "Login failed"

      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout

    redirect_to login_path, notice: "Logged out!"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
