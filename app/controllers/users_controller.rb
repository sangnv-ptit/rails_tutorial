class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  attr_reader :user

  def index
    @users = User.active.paginate page: params[:page]
  end

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
    redirect_to root_url unless user.activated?
  end

  def edit; end

  def update
    if user.update_attributes user_params
      flash[:success] = t "message.update"
      redirect_to user
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:success] = t "message.delete"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::ATTR
  end

  def signup_success user
    user.send_activation_email
    flash[:info] = t "signup_page.activate_message"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "message.login"
    redirect_to login_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def correct_user
    redirect_to root_url unless user.current_user? current_user
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:error] = t "layouts.application.error"
    redirect_to rool_url
  end
end
