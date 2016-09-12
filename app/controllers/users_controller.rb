class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :load_user
  def index
  end

  def edit
  end

  def show
  end

  def update
    if @user.update_attributes user_params
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
