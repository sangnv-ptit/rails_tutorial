class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "message.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    return unless @user.nil?
    flash[:danger] = t "layouts.application.error"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit User::ATTR
  end
end
