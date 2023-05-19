class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = @post.author
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post_id = @post.id

    if @comment.save
      flash[:success] = 'Comment created successfully.'
    else
      flash[:danger] = 'Comment could not be created.'
    end

    redirect_to user_post_path(@post.author, @post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    if @comment.destroy
      flash[:success] = 'Comment deleted successfully.'
    else
      flash[:danger] = 'Comment could not be deleted.'
    end

    redirect_to user_posts_path(@post.author, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
