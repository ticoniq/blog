require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) { Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      comment = Comment.new(author: user, post:, text: 'Valid comment')
      expect(comment).to be_valid
    end
  end

  describe 'comment_counter_updates' do
    it 'updates the post\'s comments_counter after creating a comment' do
      post.comments_counter = 0
      post.save

      expect do
        Comment.create(author: user, post:, text: 'New comment')
        post.reload
      end.to change(post, :comments_counter).by(1)
    end

    it 'updates the post\'s comments_counter after deleting a comment' do
      post.comments_counter = 3
      post.save

      comment = Comment.create(author: user, post:, text: 'To Be Deleted')

      expect do
        comment.destroy
        post.reload
      end.to change(post, :comments_counter).by(-1)
    end
  end
end
