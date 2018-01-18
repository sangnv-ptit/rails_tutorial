class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]

    if user && !user.activated? && user.authenticated?(:activation,
      params[:id])
      activate_success user
    else
      flash[:danger] = t "signup_page.activated_fail"
      redirect_to root_url
    end
  end

  private

  def activate_success user
    user.update_attributes activated: true, activated_at: Time.zone.now
    log_in user
    flash[:success] = t "signup_page.activated_success"
    redirect_to user
  end
end
