require 'spec_helper'

describe PostsController do
  describe 'GET #index' do
    context 'user not logged in' do
      it 'assigns @posts' do
        post = create(:post)
        get :index
        expect(assigns(:posts)).to eq([post])
      end

      it '@posts are published' do
        post = create(:post)
        draft = create(:draft_post)
        get :index
        expect(assigns(:posts)).to eq([post])
      end

      it 'renders posts#index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end

      it '@posts contains drafts' do
        draft = create(:draft_post)
        get :index
        expect(assigns(:posts)).to eq([draft])
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

      it 'unable to view a draft' do
        draft = create(:draft_post)
        get :show, :id => draft.id
        expect(response).to redirect_to root_url
      end
    end

    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end

      it 'views a draft' do
        draft = create(:draft_post)
        get :show, :id => draft.id
        expect(response).to render_template('show')
      end
    end
  end
end
