class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user, :check_expiration,
    only: %i(edit update)

  attr_reader :user

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if user
      send_mail user
    else
      flash.now[:danger] = t "message.email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    errors = user.errors

    if params[:user][:password].empty?
      errors.add :password, t("forgot_password.empty")
    elsif user.update_attributes user_params
      reset_password_success user && return
    else
      errors.add :error, t("layouts.application.error")
    end
    render :edit
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def valid_user
    unless user && user.activated? && user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def find_user
    @user = User.find_by email: params[:email]

    return if user
    flash[:error] = t "layouts.application.error"
    redirect_to rool_url
  end

  def check_expiration
    return unless user.password_reset_expired?
    flash[:error] = t "message.expired_password"
    redirect_to new_password_reset_url
  end

  def send_mail user
    user.create_reset_digest
    user.send_password_reset_email
    flash[:info] = t "message.forgot_password"
    redirect_to root_url
  end

  def reset_password_success user
    log_in user
    user.update_attributes reset_digest: nil
    flash[:success] = t "message.reset_password"
    redirect_to user
  end
end
