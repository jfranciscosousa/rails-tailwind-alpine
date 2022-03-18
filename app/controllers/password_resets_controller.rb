class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!

    redirect_to(login_path, notice: "Instructions have been sent to your email.")
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return if @user.present?

    not_authenticated
    nil
  end

  # rubocop:disable Metrics/AbcSize
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    @user.change_password(params[:user][:password])

    if @user.valid?
      redirect_to(login_path, notice: "Password was successfully updated.")
    else
      render :edit, status: :unprocessable_entity
    end
  end
  # rubocop:enable Metrics/AbcSize
end
