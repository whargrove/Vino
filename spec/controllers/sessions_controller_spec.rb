require 'spec_helper'

describe SessionsController, :type => :controller do
  describe 'GET #new' do
    context 'user not logged in' do
      it 'renders #new (as /login)' do
        get :new
        expect(response).to render_template('new')
      end
    end

    context 'user logged in' do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end

      it 'redirects to /admin/posts' do
        get :new
        expect(response).to redirect_to(admin_posts_url)
      end
    end
  end

  describe 'POST #create' do
    context 'user not logged in' do
      before :each do
        @user = create(:user)
      end

      context 'invalid login credentials' do
        it 'does not create a new session' do
          post :create, user_name: @user.user_name, password: 'foo'
          expect(session[:user_id]).not_to eq(@user.id)
          expect(session[:user_id]).to eq(nil)
        end
        it 'redirects to /login' do
          post :create, user_name: @user.user_name, password: 'foo'
          expect(response).to redirect_to(login_url) 
        end
        it 'has an error message' do
          post :create, user_name: @user.user_name, password: 'foo'
          expect(flash[:alert]).to eq("User name or password is invalid")
        end
      end

      context 'using valid login credentials' do
        it 'creates a new session' do
          post :create, user_name: @user.user_name, password: @user.password
          expect(session[:user_id]).to eq(@user.id)
          expect(session[:user_id]).not_to eq(nil)
        end

        it 'redirects to /admin/posts' do
          post :create, user_name: @user.user_name, password: @user.password
          expect(response).to redirect_to(admin_posts_url)
        end
      end
    end

    context 'user logged in' do
      it 'redirects to /admin/posts' do
        @user = create(:user)
        session[:user_id] = @user.id
        post :create, user_name: @user.user_name, password: @user.password
        expect(response).to redirect_to(admin_posts_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user not logged in' do
      it 'redirects to #new (as /login)' do
        delete :destroy, id: session[:user_id]
        expect(response).to redirect_to(login_url)
      end
    end

    context 'user logged in' do
      before :each do
        @user = create(:user)
        session[:user_id] = @user.id
      end

      it 'deletes the session' do
        delete :destroy, id: session[:user_id]
        expect(session[:user_id]).to eq(nil)
        expect(session[:user_id]).not_to eq(@user.id)
      end

      it 'redirects to /' do
        delete :destroy, id: session[:user_id]
        expect(response).to redirect_to(root_url)
      end
    end
  end
end