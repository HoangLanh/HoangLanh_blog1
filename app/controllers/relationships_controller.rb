class RelationshipsController < ApplicationController

  def index
    @user  = User.find params[:id]
    relationship = params[:relationship]
    @title = t "follow_user.#{relationship}"
    @users = @user.send(relationship)
    render "users/show_follow"
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
