require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'posts index' do
    before(:each) do
      @first_user = User.create(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'I am the first user.',
                                postscounter: 0)

      @first_post = Post.create(title: 'First Post', text: 'This is the first post.', author: @first_user,
                                comments_counter: 0, likes_counter: 0)
      @second_post = Post.create(title: 'Second Post', text: 'This is the second post.', author: @first_user,
                                 comments_counter: 0, likes_counter: 0)
      @third_post = Post.create(title: 'Third Post', text: 'This is the third post.', author: @first_user,
                                comments_counter: 0, likes_counter: 0)
      @fourth_post = Post.create(title: 'Fourth Post', text: 'This is the fourth post.', author: @first_user,
                                 comments_counter: 0, likes_counter: 0)

      @first_comment = Comment.create(text: 'This is the first comment', author: @first_user, post: @first_post)
      @second_comment = Comment.create(text: 'This is the first comment', author: @first_user, post: @first_post)
      @third_comment = Comment.create(text: 'This is the first comment', author: @first_user, post: @first_post)
      @fourth_comment = Comment.create(text: 'This is the first comment', author: @first_user, post: @first_post)
      @fifth_comment = Comment.create(text: 'This is the first comment', author: @first_user, post: @first_post)
      @sixth_comment = Comment.create(text: 'This is the first comment', author: @first_user, post: @first_post)

      @like = Like.create(author: @first_user, post: @first_post)
    end

    it 'Should show user profile picture' do
      visit user_posts_path(@first_user)
      expect(@first_user.photo).to match(%r{^https://i.imgur.com/1.(jpe?g|gif|png)$})
    end

    it 'Should show user name' do
      visit user_posts_path(@first_user)
      expect(page).to have_content(@first_user.name)
    end

    it 'Should show number of user posts' do
      visit user_posts_path(@first_user)
      expect(page).to have_content(@first_user.postscounter)
    end

    it 'Should show post title' do
      visit user_posts_path(@first_user)
      expect(page).to have_content(@first_post.title)
    end

    it 'Should show some of post body' do
      visit user_posts_path(@first_user)
      expect(page).to have_content(@first_post.text)
    end

    it 'Should show post first comments' do
      visit user_posts_path(@first_user)
      expect(page).to have_content(@first_post.recent_comments.first.text)
    end

    it 'Should show number of comments on a post' do
      visit user_posts_path(@first_user)
      expect(page).to have_content(@first_post.comments_counter)
    end

    it 'Should show number of likes on a post' do
      visit user_posts_path(@first_user)
      expect(page).to have_content(@first_post.likes_counter)
    end

    it 'Should redirect to show post page when I click on a post' do
      visit user_posts_path(@first_user)
      click_link(@first_post.title)
      expect(page).to have_current_path(user_post_path(@first_user, @first_post))
    end
  end

  describe 'posts show page' do
    before(:each) do
      @first_user = User.create(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'I am the first user.',
                                postscounter: 0)

      @first_post = Post.create(title: 'First Post', text: 'This is the first post.', author: @first_user,
                                comments_counter: 0, likes_counter: 0)
      @second_post = Post.create(title: 'Second Post', text: 'This is the second post.', author: @first_user,
                                 comments_counter: 0, likes_counter: 0)
      @third_post = Post.create(title: 'Third Post', text: 'This is the third post.', author: @first_user,
                                comments_counter: 0, likes_counter: 0)
      @fourth_post = Post.create(title: 'Fourth Post', text: 'This is the fourth post.', author: @first_user,
                                 comments_counter: 0, likes_counter: 0)

      @first_comment = Comment.create(text: 'This is the first comment', author: @first_user, post: @first_post)
      @second_comment = Comment.create(text: 'This is the second comment', author: @first_user, post: @first_post)
      @third_comment = Comment.create(text: 'This is the third comment', author: @first_user, post: @first_post)
      @fourth_comment = Comment.create(text: 'This is the fourth comment', author: @first_user, post: @first_post)
      @fifth_comment = Comment.create(text: 'This is the fifth comment', author: @first_user, post: @first_post)
      @sixth_comment = Comment.create(text: 'This is the sixth comment', author: @first_user, post: @first_post)

      @like = Like.create(author: @first_user, post: @first_post)
    end

    it 'Should show post title' do
      visit user_post_path(@first_user, @first_post)
      expect(page).to have_content(@first_post.title)
    end

    it 'Should show who wrote the post' do
      visit user_post_path(@first_user, @first_post)
      expect(page).to have_content(@first_post.author.name)
    end

    it 'Should show number of post comments' do
      visit user_post_path(@first_user, @first_post)
      expect(page).to have_content(@first_post.comments_counter)
    end

    it 'Should show number of post likes' do
      visit user_post_path(@first_user, @first_post)
      expect(page).to have_content(@first_post.likes_counter)
    end

    it 'Should show post body' do
      visit user_post_path(@first_user, @first_post)
      expect(page).to have_content(@first_post.text)
    end

    it 'Should show user name of each commentor' do
      visit user_post_path(@first_user, @first_post)
      expect(page).to have_content(@first_comment.author.name)
    end
  end
end
