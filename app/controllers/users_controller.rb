class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :load_user
  def index
    @search = User.search params[:q]
    @users = @search.result.order(created_at: :desc).page params[:page]
  end

  def edit
  end

  def show
    @user = User.find_by id: params[:id]
    @posts = @user.posts.order(created_at: :desc).page params[:page]
    unless @post
    flash[:danger] = "No post"
    end
  end

  def update
    if @user.update_attributes user_params
      sign_in(@user, bypass: true)
      flash[:update_success] = t "user.edit"
      redirect_to user_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end
	def load_user
	  @user = User.find_by id: params[:id]
	end

end
