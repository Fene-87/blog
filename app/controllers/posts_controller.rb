class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.author = current_user

    if @post.save
      flash[:success] = 'Post created successfully.'
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:danger] = 'Post could not be created.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
