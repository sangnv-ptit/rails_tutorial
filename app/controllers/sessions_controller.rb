class SessionsController < ApplicationController
  def new; end

  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase

    if user && user.authenticate(session[:password])
      login_success user
    else
      login_fail
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_success user
    log_in user

    if params[:session][:remember_me] == Settings.remember
      remember user
    else
      forget user
    end
    redirect_back_or root_url
  end

  def login_fail
    flash.now[:danger] = t "message.invalid"
    render :new
  end
end
