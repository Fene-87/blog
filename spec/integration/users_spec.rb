require 'rails_helper'

RSpec.describe 'Users', type: :system do
    describe 'index page' do
        before(:each) do
            @first_user = User.create(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'I am the first user.', postscounter: 0)
            @second_user = User.create(name: 'Fene', photo: 'https://i.imgur.com/1.jpg', bio: 'I am the second user.', postscounter: 0)
        end

        it 'Shows the right content' do
            visit '/'
            expect(page).to have_content('Here is a list of all users')
        end

        it 'Shows username of all users' do
            visit '/'
            expect(page).to have_content(@first_user.name)
        end

        it 'Shows user profile picture' do
            visit '/'
            expect(@first_user.photo).to match(%r{^https://i.imgur.com/1.(jpe?g|gif|png)$})
        end

        it 'Shows the number of a user posts' do
            visit '/'
            expect(page).to have_content(@first_user.postscounter)
        end

        it 'Should redirect to user show page' do
            visit '/'
            click_link(@first_user.name)
            expect(page).to have_current_path(user_path(@first_user))
        end
    end

    describe 'show page' do
        before(:each) do
            @first_user = User.create(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'I am the first user.', postscounter: 0)
            @first_post = Post.create(title: 'First Post', text: 'This is the first post.', author: @first_user, comments_counter: 0, likes_counter: 0)
            @second_post = Post.create(title: 'Second Post', text: 'This is the second post.', author: @first_user, comments_counter: 0, likes_counter: 0)
            @third_post = Post.create(title: 'Third Post', text: 'This is the third post.', author: @first_user, comments_counter: 0, likes_counter: 0)
            @fourth_post = Post.create(title: 'Fourth Post', text: 'This is the fourth post.', author: @first_user, comments_counter: 0, likes_counter: 0)
        end
        
        it 'Should show user profile picture' do
            visit user_path(@first_user)
            expect(@first_user.photo).to match(%r{^https://i.imgur.com/1.(jpe?g|gif|png)$})
        end

        it 'Should show user name' do
            visit user_path(@first_user)
            expect(page).to have_content(@first_user.name)
        end

        it 'Should show number of user posts' do
            visit user_path(@first_user)
            expect(page).to have_content(@first_user.postscounter)
        end

        it 'Should show user bio' do
            visit user_path(@first_user)
            expect(page).to have_content(@first_user.bio)
        end

        it 'Should show user name' do
            visit user_path(@first_user)
            expect(page).to have_content(@first_user.name)
        end

        it 'Should show user first three posts' do
            visit user_path(@first_user)
            expect(page).to have_content(@first_user.recent_posts.first.title)
            expect(page).to have_content(@first_user.recent_posts.second.title)
            expect(page).to have_content(@first_user.recent_posts.third.title)
        end

        it 'Shows a button to view all posts' do
            visit user_path(@first_user)
            expect(page).to have_link('See all posts')
            expect(page).to have_current_path("/users/#{@first_user.id}")
        end

        it 'Should redirect to post show page when click user post' do
            visit user_path(@first_user)
            click_link(@second_post.title)
            expect(page).to have_current_path(user_post_path(@first_user, @second_post))
        end

        it 'Should redirect to post index page when click view all posts' do
            visit user_path(@first_user)
            click_link('See all posts')
            expect(page).to have_current_path("/users/#{@first_user.id}")
        end
    end
end