require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'creation' do
    before :all do
      @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am John Doe')
      @post = Post.create(author_id: @user.id, title: 'My Post', text: 'This is my post')
      @comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'This is my comment')
    end

    it "text can't be blank" do
      @comment.text = nil
      expect(@comment).to_not be_valid
    end

    it "author_id can't be blank" do
      @comment.author_id = nil
      expect(@comment).to_not be_valid
    end

    it 'author_id must be an integer' do
      @comment.author_id = 'a'
      expect(@comment).to_not be_valid
    end

    it 'author_id must be greater than 0' do
      @comment.author_id = 0
      expect(@comment).to_not be_valid
    end

    it "post_id can't be blank" do
      @comment.post_id = nil
      expect(@comment).to_not be_valid
    end

    it 'post_id must be an integer' do
      @comment.post_id = 'a'
      expect(@comment).to_not be_valid
    end

    it 'post_id must be greater than 0' do
      @comment.post_id = -1
      expect(@comment).to_not be_valid
    end

    it 'should return the increased comments_counter' do
      @user.postscounter = 0
      @user.save!
      @post = Post.create(author: @user, title: 'My Post', text: 'This is my post', comments_counter: 0,
                          likes_counter: 0)
      @post.save!

      @comment = @post.comments.create!(author_id: @user.id, post_id: @post.id, text: 'This is my comment')
      @comment.update_comments_counter
      @comment.update_comments_counter

      expect(@post.comments_counter).to eq(3)
    end
  end
end
