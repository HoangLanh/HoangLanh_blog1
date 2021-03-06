class CommentsController < ApplicationController
  before_action :load_post, except: [:index, :show]
  before_action :load_exist_comment, except: [:index, :show]
  load_and_authorize_resource

  def new
  end

  def create
    @comment = @post.comments.build comment_params
    respond_to do |format|
    if @comment.save
      flash[:success] = t "create_success",
        objects:"Comment"
    else
      flash[:danger] = t "create_error",
        objects: "Comment"
    end
      format.html {redirect_to post_path(@post)}
      format.js
    end
  end

  def edit
  end

  def update
    respond_to do |format|
    if @comment.update_attributes comment_params
      flash[:success] = t "update_success",
        objects: "Comment"
    else
      flash[:danger] = t "controllers.flash.common.update_error",
        objects: t("Comment")
    end
      format.html {redirect_to post_path(@post)}
      format.js
  end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        flash[:success] = t "destroy_success",
          objects: t("Comment")
      else
        flash[:danger] = t "destroy_error",
          objects: t("Comment")
      end
      format.html {redirect_to post_path(@post)}
      format.js
  end
  end

  
  private
  def comment_params
    params.require(:comment).permit :user_id, :content, :rating
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
    unless @post
      flash[:danger] = t "No_post"
      redirect_to posts_path
    end
  end
  def load_exist_comment
    @exist_comments = @post.comments.where user_id: current_user.id
  end  
end
