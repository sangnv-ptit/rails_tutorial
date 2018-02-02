class MicropostsController < ApplicationController
  attr_reader :micropost

  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  def create
    @micropost = current_user.microposts.build micropost_params

    if micropost.save
      flash[:success] = t "micropost.create"
      redirect_to root_url
    else
      @feed_items = current_user.microposts.most_recent
        .paginate page: params[:page]
      render "static_pages/home"
    end
  end

  def destroy
    micropost.destroy
    flash[:success] = t "micropost.delete"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::ATTR
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless micropost
  end
end
