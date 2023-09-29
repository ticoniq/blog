require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      post = Post.new(title: 'Valid Post', author: user, comments_counter: 0, likes_counter: 0)
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = Post.new(author: user, comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is not valid with a long title' do
      post = Post.new(title: 'A' * 251, author: user, comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'is not valid with a negative comments_counter' do
      post = Post.new(title: 'Negative Counter Post', author: user, comments_counter: -1, likes_counter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'is not valid with a non-integer likes_counter' do
      post = Post.new(title: 'Non-Integer Counter Post', author: user, comments_counter: 0, likes_counter: 1.5)
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be an integer')
    end
  end

  describe 'post_counter_updates' do
    it 'updates the user\'s posts_counter after creating a post' do
      user.posts_counter = 0
      user.save

      expect do
        Post.create(title: 'New Post', author: user, comments_counter: 0, likes_counter: 0)
        user.reload
      end.to change(user, :posts_counter).by(1)
    end

    it 'updates the user\'s posts_counter after deleting a post' do
      user.posts_counter = 3
      user.save

      post = Post.create(title: 'To Be Deleted', author: user, comments_counter: 0, likes_counter: 0)

      expect do
        post.destroy
        user.reload
      end.to change(user, :posts_counter).by(-1)
    end
  end

  describe 'latest_comments' do
    it 'returns the 5 latest comments for the post' do
      post = Post.create(title: 'Post with Comments', author: user, comments_counter: 0, likes_counter: 0)
      comment2 = Comment.create(author: user, post:, text: 'Comment 2')
      comment3 = Comment.create(author: user, post:, text: 'Comment 3')
      comment4 = Comment.create(author: user, post:, text: 'Comment 4')
      comment5 = Comment.create(author: user, post:, text: 'Comment 5')
      comment6 = Comment.create(author: user, post:, text: 'Comment 6')

      latest_comments = post.latest_comments

      expect(latest_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end
end
