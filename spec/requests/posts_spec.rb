require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) { Post.create(title: 'Post with Comments', author: user, comments_counter: 0, likes_counter: 0) }

  describe 'GET /users/:user_id/posts' do
    it 'renders the index template with correct placeholder text' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('posts/index')
      expect(response.body).to include('List of Posts')
    end
  end

  describe 'GET #show' do
    before do
      get user_post_path(user, post)
    end

    context 'renders the show template' do
      it 'response status is correct' do
        expect(response).to have_http_status(200)
      end

      it 'correct template is rendered' do
        expect(response).to render_template(:show)
      end

      it 'the response body includes correct placeholder text' do
        expect(response.body).to include('Title: Sample Post')
        expect(response.body).to include('Content: This is a sample post.')
      end
    end
  end
end
