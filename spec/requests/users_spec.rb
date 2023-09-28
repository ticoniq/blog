require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }

  describe 'GET /users' do
    it 'renders the index template with correct placeholder text' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template('users/index')
      expect(response.body).to include('List of Users')
    end
  end

  describe 'GET #show' do
    before do
      get user_path(user)
    end

    context 'renders the show template' do
      it 'correct template is rendered' do
        expect(response).to render_template(:show)
      end
      it 'response status is correct' do
        expect(response).to have_http_status(200)
      end
      it 'the response body includes correct placeholder text' do
        expect(response.body).to include('User (1) Details')
      end
    end
  end
end
