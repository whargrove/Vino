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

        context 'status is draft' do
          it 'is not published' do
            post :create, post: attributes_for(:draft_post)
            post = Post.find_by title: 'post'
            post.status.should equal("draft")
          end

          it 'is not scheduled to be published' do
            post :create, post: attributes_for(:draft_post)
            post = Post.find_by title: 'post'
            post.published_at.should_be nil
          end
        end

        context 'status is scheduled' do
          it 'is not published' do
            post :create, post: attributes_for(:scheduled_post)
            post = Post.find_by title: 'post'
            post.status.should equal("scheduled")
          end

          it 'is scheduled to be published' do
            post :create, post: attributes_for(:scheduled_post)
            post = Post.find_by title: 'post'
            post.published_at.should > DateTime.now.utc
          end
        end

        context 'status is published' do
          it 'is published' do
            post :create, post: attributes_for(:published_post)
            post = Post.find_by title: 'post'
            post.status.should equal("published")
          end
        end
      end

      context 'without valid attributes' do
        it 'does not create a new post' do
          expect {
            post :create, post: attributes_for(:invalid_post)
          }.to_not change(Post, :count).by(1)
        end

        it 're-renders #new' do
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

        context 'status is draft' do
          it 'updates an existing draft' do
            patch :update, id: @post, post: attributes_for(:draft_post)
            post = Post.find_by title: 'draft post'
            post.draft?.should be_true
          end

          it 'is updated and scheduled to be published' do
            @draft_post = create(:draft_post)
            patch :update, id: @draft_post, post: attributes_for(:scheduled_post)
            post = Post.find_by title: 'scheduled post'
            post.scheduled?.should be_true
          end

          it 'is updated and published' do
            @draft_post = create(:draft_post)
            patch :update, id: @draft_post, post: attributes_for(:published_post)
            post = Post.find_by title: 'published_post'
            post.published?.should be_true
          end
        end

        context 'status is scheduled' do
          it 'it updates an existing scheduled post' do
            pending("Not yet implemented")
          end

          it 'is updated and rescheduled to be published' do
            pending("Not yet implemented")
          end

          it 'is updated and published' do
            pending("Not yet implemented")
          end
        end

        context 'status is published' do
          it 'is updated and remains published' do
            patch :update, id: @post, post: attributes_for(:post)
            post = Post.find_by title: 'post'
            post.published?.should be_true
          end
        end
      end

      context 'without valid attributes' do
        it 'does not change post attributes' do
          patch :update, id: @post, post: attributes_for(:invalid_post)
          @post.reload
          expect(@post.title).to_not eq('')
          expect(@post.user_id).to eq(1)
        end

        it 're-renders #edit' do
          patch :edit, id: @post, post: attributes_for(:invalid_post)
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
