require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before :all do
      @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am John Doe')
    end

    it "name can't be blank" do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it "photo can't be blank" do
      @user.photo = nil
      expect(@user).to_not be_valid
    end

    it "bio can't be blank" do
      @user.bio = nil
      expect(@user).to_not be_valid
    end

    it "postscounter can't be blank" do
      @user.postscounter = nil
      expect(@user).to_not be_valid
    end

    it 'postscounter must be an integer' do
      @user.postscounter = 'a'
      expect(@user).to_not be_valid
    end

    it 'postscounter must be greater than or equal to 0' do
      @user.postscounter = -1
      expect(@user).to_not be_valid
    end

    it 'should return the most recent posts' do
      @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am John Doe')
      @user.postscounter = 4
      @user.save!
      @post1 = @user.posts.create!(title: 'My first Post', text: 'This is my post', comments_counter: 2, likes_counter: 1)
      @post2 = @user.posts.create!(title: 'My second Post', text: 'This is my post',comments_counter: 2, likes_counter: 1)
      @post3 = @user.posts.create!(title: 'My third Post', text: 'This is my post', comments_counter: 2, likes_counter: 1)
      @post4 = @user.posts.create!(title: 'My last Post', text: 'This is my post', comments_counter: 2, likes_counter: 1)
    
      expect(@user.recent_posts).to eq([@post4, @post3, @post2])
    end
  end
end
