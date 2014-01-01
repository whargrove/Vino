require 'spec_helper'

describe PostsController do
  describe 'GET index' do
    it 'assigns @posts' do
      post = create(:post)
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    it 'renders posts#index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET /posts/:id' do
    it 'assigns @post' do
      post = create(:post)
      get :show, :id => post.id
      expect(assigns(:post)).to eq(post)
    end

    it 'renders posts#show template' do
      post = create(:post)
      get :show, :id => post.id
      expect(response).to render_template('show')
    end
  end
end