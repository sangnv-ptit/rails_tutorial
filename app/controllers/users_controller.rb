class UsersController < ApplicationController
  attr_reader :user

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if user.save
      signup_success user
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    return if user
    flash[:danger] = t "layouts.application.error"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit User::ATTR
  end

  def signup_success user
    flash[:success] = t "message.welcome"
    redirect_to user
  end
end
