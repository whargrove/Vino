require 'spec_helper'

describe UsersController do
  describe 'GET #new' do
    context 'user not logged in' do
      it 'renders #new' do
        get :new
        expect(response).to render_template("new")
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      expect {
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by(1)
    end

    it 'redirects to /' do
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to root_url
    end
  end
end
