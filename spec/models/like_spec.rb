require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) { Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0) }

  describe 'likes_counter_updates' do
    it 'updates the post\'s likes_counter after creating a like' do
      post.likes_counter = 0
      post.save

      expect do
        Like.create(author: user, post:)
        post.reload
      end.to change(post, :likes_counter).by(1)
    end

    it 'updates the post\'s likes_counter after deleting a like' do
      post.likes_counter = 3
      post.save

      like = Like.create(author: user, post:)

      expect do
        like.destroy
        post.reload
      end.to change(post, :likes_counter).by(-1)
    end
  end
end
