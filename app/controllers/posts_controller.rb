class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Post.ransack(search_params)
    @posts = @search.result.order(created_at: :desc).page params[:page]
    @posts_followed = Post.of_users User.first
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = t "controllers.flash.common.update_success",
        objects: t("activerecord.model.post")
    else
      flash[:danger] = t "controllers.flash.common.update_error",
        objects: t("activerecord.model.post")
    end
    redirect_to post_path(@post)
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = t "post.success",
        objects: t("post.post")
      redirect_to posts_url
    else
      render :new
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t "post.success"
    else
      flash[:danger] = t "post.failed"
    end
    redirect_to posts_url
  end 

  def show
    @post = Post.find_by id: params[:id]
    @comment = @post.comments.build
    if user_signed_in?
      @current_comment = @post.comments.find_by user_id: current_user.id
    end
    @comments = @post.comments.order(created_at: :desc).page params[:page]    
    unless @post
      flash[:danger] = "No post"
      redirect_to posts_url
    end
  end

  private
  
  def search_params
    params[:q].to_hash if params[:q]
  end

  def post_params
    params.require(:post).permit :title, :content, :user_id, :picture
  end

  def load_post
    @post = Post.find_by id: params[:id]
  end
end
