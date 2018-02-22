class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    microposts = current_user.feed
    @micropost = microposts.build
    @feed_items = microposts.most_recent.paginate page: params[:page]
  end

  def help; end

  def about; end

  def contact; end
end
