class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    if current_user
      redirect_to(root_path)

      return
    end

    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    if current_user
      redirect_to(root_path)

      return
    end

    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, notice: "User was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to root_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user

    logout
    @user.destroy

    redirect_to login_path, notice: "User was successfully destroyed."
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
