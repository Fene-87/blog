class LikesController < ApplicationController
    def create
        @post = Post.find(params[:id])
        @user = current_user
        @like = Like.new(author: @user, post: @post)
        @like.save

        flash[:success] = 'Liked'
        redirect_to user_post_path(@user, @post)
    end
end