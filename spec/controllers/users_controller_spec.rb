require 'spec_helper'

describe UsersController do
  describe "GET user/new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST user/" do
    it "creates a new user" do
      post :create, :user => attributes_for(:user)
      expect(User.where(:user_name => 'heisenberg')).to have(1).record
    end
  end
end
