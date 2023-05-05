require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'creation' do
    before :all do
      @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am John Doe')
      @post = Post.create(author_id: @user.id, title: 'My Post', text: 'This is my post')
    end

    it "author_id can't be blank" do
      @post.author_id = nil
      expect(@post).to_not be_valid
    end

    it "title can't be blank" do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it "title can't exceed 250 characters" do
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
    end

    it "text can't be blank" do
      @post.text = nil
      expect(@post).to_not be_valid
    end

    it "comments_counter can't be blank" do
      @post.comments_counter = nil
      expect(@post).to_not be_valid
    end

    it 'comments_counter must be an integer' do
      @post.comments_counter = 'a'
      expect(@post).to_not be_valid
    end

    it 'comments_counter must be greater than or equal to 0' do
      @post.comments_counter = -1
      expect(@post).to_not be_valid
    end

    it "likes_counter can't be blank" do
      @post.likes_counter = nil
      expect(@post).to_not be_valid
    end

    it 'likes_counter must be an integer' do
      @post.likes_counter = 'a'
      expect(@post).to_not be_valid
    end

    it 'likes_counter must be greater than or equal to 0' do
      @post.likes_counter = -1
      expect(@post).to_not be_valid
    end

    it 'should return the most recent comments' do
      @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am John Doe')
      @user.postscounter = 4
      @user.save!
      @post = @user.posts.create!(title: 'My first Post', text: 'This is my post', comments_counter: 0, likes_counter: 0)
      @post.save!

      @comment1 = @post.comments.create!(author_id: @user.id, post_id: @post.id, text: 'This is my first comment')
      @comment2 = @post.comments.create!(author_id: @user.id, post_id: @post.id, text: 'This is my second comment')
      @comment3 = @post.comments.create!(author_id: @user.id, post_id: @post.id, text: 'This is my third comment')
      @comment4 = @post.comments.create!(author_id: @user.id, post_id: @post.id, text: 'This is my fourth comment')
      @comment5 = @post.comments.create!(author_id: @user.id, post_id: @post.id, text: 'This is my fifth comment')
      @comment6 = @post.comments.create!(author_id: @user.id, post_id: @post.id, text: 'This is my sixth comment')
    
      expect(@post.recent_comments).to eq([@comment6, @comment5, @comment4, @comment3, @comment2])
    end

    it 'should return the increased posts_counter' do
      @user.postscounter = 0
      @user.save!

      @post = Post.create(author: @user, title: 'My Post', text: 'This is my post', comments_counter: 0, likes_counter: 0)
      @post.update_post_counter
      @post.update_post_counter
      
      expect(@user.postscounter).to eq(3)
    end
  end
end
