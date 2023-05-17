require 'rails_helper'

RSpec.describe 'Users', type: :system do
    describe 'index page' do
        before(:each) do
            @first_user = User.create(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'I am the first user.', postscounter: 0)
            @second_user = User.create(name: 'Fene', photo: 'https://i.imgur.com/1.jpg', bio: 'I am the second user.', postscounter: 0)
            @first_post = Post.create(title: 'First Post', text: 'This is the first post.', author: @first_user, comments_counter: 0, likes_counter: 0)
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
end