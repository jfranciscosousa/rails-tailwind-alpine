require "rails_helper"

RSpec.describe UsersController do
  describe "GET #new" do
    it "renders the correct template" do
      get signup_path

      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end

    it "redirects to root path if already logged in" do
      user = create(:user)
      login_user(user)

      get signup_path

      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #edit" do
    it "renders the correct template" do
      user = create(:user)
      login_user(user)

      get edit_user_path

      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end

    it "redirects to root_path if already logged in" do
      get edit_user_path

      expect(response).to redirect_to(login_path)
    end
  end

  describe "POST #create" do
    it "redirects to login path on a successful signup" do
      user_params = attributes_for(:user)

      post user_path, params: { user: user_params }

      expect(response).to redirect_to(login_path)
      expect(User.last.email).to eq(user_params[:email])
    end

    it "renders the login template if login is bad" do
      user_params = attributes_for(:user, password_confirmation: "bad_foobar")

      post user_path, params: { user: user_params }

      expect(response).to render_template(:new)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "redirects to root path if already logged in" do
      user = create(:user)
      user_params = attributes_for(:user)
      login_user(user)

      expect do
        post user_path, params: { user: user_params }
      end.not_to change(User, :count)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PUT #update" do
    it "redirects to root path after a successful user edit" do
      user = create(:user)
      user_params = attributes_for(:user, password: "new_password", password_confirmation: "new_password")
      login_user(user)

      put user_path, params: { user: user_params }
      user.reload

      expect(response).to redirect_to(root_path)
      expect(user.email).to eq(user_params[:email])
      expect(user.valid_password?(user_params[:password])).to be(true)
    end

    it "returns unprocessable if invalid params" do
      user = create(:user)
      user_params = attributes_for(:user, password_confirmation: "bad")
      login_user(user)

      put user_path, params: { user: user_params }

      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "redirects to login path if not logged in" do
      user_params = attributes_for(:user)

      put user_path, params: { user: user_params }

      expect(response).to redirect_to(login_path)
    end
  end

  describe "DELETE #destroy" do
    it "redirects to login path after destroying the user" do
      user = create(:user)
      create_list(:todo, 3, user: user)
      login_user(user)

      expect do
        delete user_path
      end.to change(User, :count).by(-1)
      expect(Todo.count).to eq(0)
      expect(response).to redirect_to(login_path)
      expect(session[:user_id]).to be_nil
    end

    it "redirects to login path if not logged in" do
      delete user_path

      expect(response).to redirect_to(login_path)
    end
  end
end
