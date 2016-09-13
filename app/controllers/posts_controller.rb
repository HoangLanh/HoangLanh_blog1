class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @search = Post.search params[:q]
    @posts = @search.result.order(created_at: :desc).page params[:page]
  end

  def edit
  end

  def show
    @post = Post.find_by id: params[:id]
    @comment = Comment.new
    @comments = @post.comments.order created_at: :desc
    unless @post
      flash[:danger] = "No post"
      redirect_to posts_url
    end
  end

  def update
  end

end
