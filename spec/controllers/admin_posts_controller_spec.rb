require 'spec_helper'

describe Admin::PostsController do
  describe 'GET #index' do
    context 'user not logged in' do
      it 'redirects to /login' do
        get :index
        expect(response).to redirect_to('/login')
      end
    end

    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end

      it 'assigns @posts' do
        post = create(:post)
        get :index
        expect(assigns(:posts)).to eq([post])
      end

      it 'renders #index template' do
        get :index
        expect(response).to render_template('index')
      end
    end
  end

  describe 'GET #new' do
    context 'user not logged in' do
      it 'redirects to /login' do
        get :new
        expect(response).to redirect_to('/login')
      end
    end
    
    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end

      it 'assigns a new post to @post' do
        post = create(:post)
        get :new
        assigns(:post).should be_a_new(Post)
      end

      it 'renders #new' do
        get :new
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
    context 'user not logged in' do
      it 'redirects to /login' do
        post = create(:post)
        get :edit, :id => post.id
        expect(response).to redirect_to('/login')
      end
    end

    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end
      
      it 'assigns @post' do
        post = create(:post)
        get :edit, :id => post.id
        expect(assigns(:post)).to eq(post)
      end

      it 'renders #edit' do
        post = create(:post)
        get :edit, :id => post.id
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'POST #create' do
    context 'user not logged in' do
      it 'redirects to /login' do
        post :create, :post => attributes_for(:post)
        expect(response).to redirect_to('/login')
      end
    end

    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id        
      end

      context 'with valid attributes' do
        it 'creates a new post' do
          expect {
            post :create, post: attributes_for(:post)
          }.to change(Post, :count).by(1)
        end

        it 'redirects to /admin/posts' do
          post :create, post: attributes_for(:post)
          expect(response).to redirect_to admin_posts_url
        end
      end

      context 'without valid attributes' do
        it 'does not create a new post' do
          pending("Post model needs validation rules")
          expect {
            post :create, post: attributes_for(:invalid_post)
          }.to_not change(Post, :count).by(1)
        end

        it 're-renders #new' do
          pending("Post model needs validation rules")
          post :create, post: attributes_for(:invalid_post)
          expect(response).to render_template('new')
        end
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @post = create(:post)
    end

    context 'user not logged in' do
      it 'redirects to /login' do
        patch :update, :id => @post.id
        expect(response).to redirect_to('/login')
      end
    end

    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id        
      end

      context 'with valid attributes' do
        it 'assigns requested post to @post' do
          patch :update, id: @post, post: attributes_for(:post)
          expect(assigns(:post)).to eq(@post)
        end

        it 'changes @post attributes' do
          patch :update, id: @post, post: attributes_for(:post, title: 'foo', content: 'bar')
          @post.reload
          expect(@post.title).to eq('foo')
          expect(@post.content).to eq('bar')
        end

        it 'redirects to /admin/posts' do
          patch :update, id: @post, post: attributes_for(:post)
          expect(response).to redirect_to admin_posts_url
        end
      end

      context 'without valid attributes' do
        it 'does not change post attributes' do
          pending("Post model needs validation rules")
          patch :update, id: @post, post: attributes_for(:invalid_post)
          @post.reload
          expect(@post.title).to_not eq('')
          expect(@post.user_id).to eq(1)
        end

        it 're-renders #edit' do
          pending("Post model needs validation rules")
          patch :edit, post: attributes_for(:invalid_post)
          expect(response).to render_template('edit')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @post = create(:post)
    end

    context 'user not logged in' do
      it 'redirects to /login' do
        delete :destroy, :id => @post.id
        expect(response).to redirect_to('/login')
      end
    end

    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id        
      end

      it 'deletes the post' do
        expect {
          delete :destroy, id: @post
        }.to change(Post, :count).by(-1)
      end

      it 'redirects to /admin/posts' do
        delete :destroy, id: @post
        expect(response).to redirect_to(admin_posts_url)
      end
    end
  end
end
