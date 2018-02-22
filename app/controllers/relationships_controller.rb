class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: %i(index show)

  attr_reader :user

  def index
    @title = t "relationship.following"
    @users = user.following.paginate page: params[:page]
    render "users/show_follow"
  end

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow user
    @relationship_action =
      current_user.active_relationships.find_by followed_id: user.id
    respond_ajax
  end

  def show
    @title = t "relationship.followers"
    @users = user.followers.paginate page: params[:page]
    render "users/show_follow"
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow user
    @relationship_action = current_user.active_relationships.build
    respond_ajax
  end

  private

  def respond_ajax
    respond_to do |format|
      format.html{redirect_to user}
      format.js
    end
  end

  def find_user
    return if (@user = User.find_by id: params[:id])

    redirect_fail
  end

  def find_user_for_create
    return if (@user = User.find_by id: params[:followed_id])
    redirect_fail
  end

  def find_user_for_destroy
    relationship = Relationship.find_by id: params[:id]
    return redirect_fail unless relationship
    @user = relationship.followed
  end

  def redirect_fail
    flash[:error] = t "layouts.application.error"
    redirect_to rool_path
  end
end
