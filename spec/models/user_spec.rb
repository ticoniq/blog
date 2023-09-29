require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'John Doe', posts_counter: 0) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with a negative posts_counter' do
      user.posts_counter = -1
      expect(user).not_to be_valid
    end

    it 'is not valid with a non-integer posts_counter' do
      user.posts_counter = 1.5
      expect(user).not_to be_valid
    end
  end

  describe 'latest_posts' do
    it 'returns the 3 latest posts' do
      user = User.create(name: 'John Doe', posts_counter: 0)

      post2 = user.posts.create(title: 'Post 2', comments_counter: 0, likes_counter: 0, created_at: 2.days.ago)
      post3 = user.posts.create(title: 'Post 3', comments_counter: 0, likes_counter: 0, created_at: 1.day.ago)
      post4 = user.posts.create(title: 'Post 4', comments_counter: 0, likes_counter: 0, created_at: Time.now)

      latest_posts = user.latest_posts

      expect(latest_posts).to eq([post4, post3, post2])
    end
  end
end
