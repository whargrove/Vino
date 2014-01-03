require 'spec_helper'

describe PostsController do
  describe 'GET #index' do
    context 'user not logged in' do
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
  end

  describe 'GET #show' do
    context 'user not logged in' do
      it 'assigns @post' do
        post = create(:post)
        get :show, :id => post.id
        expect(assigns(:post)).to eq(post)
      end

      it 'renders #show' do
        post = create(:post)
        get :show, :id => post.id
        expect(response).to render_template('show')
      end
    end
  end
end