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
    if user.activated?
      log_in user
      remember user
    else
      flash[:warning] = t "signup_page.activated_suggest"
      redirect_to root_url
    end
  end

  def login_fail
    flash.now[:danger] = t "message.invalid"
    render :new
  end

  def remember user
    if params[:session][:remember_me] == "1"
      remember user
    else
      forget user
    end
    redirect_back_or user
  end
end
