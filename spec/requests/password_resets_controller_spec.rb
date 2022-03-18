require "rails_helper"

RSpec.describe PasswordResetsController do
  describe "POST #create" do
    it "delivers an email with password reset instructions" do
      user = create(:user)

      expect do
        post password_resets_path, params: { email: user.email }
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(response).to redirect_to(login_path)
    end

    it "doesn't deliver an email if no user has that email" do
      email = "doesntexist@mail.com"

      expect do
        post password_resets_path, params: { email: email }
      end.to change { ActionMailer::Base.deliveries.count }.by(0)
      expect(response).to redirect_to(login_path)
    end
  end

  describe "GET #edit" do
    it "delivers an email with password reset instructions" do
      user = create(:user)
      user.deliver_reset_password_instructions!

      get edit_password_reset_path(user.reset_password_token)

      expect(response).to render_template(:edit)
    end

    it "redirects to login path if token is invalid" do
      get edit_password_reset_path("bad token")

      expect(response).to redirect_to(login_path)
    end
  end

  describe "PUT #update" do
    it "updates the password given a valid token" do
      user = create(:user)
      user.deliver_reset_password_instructions!

      put password_reset_path(user.reset_password_token), params: { user: { password: "new_foobar", password_confirmation: "new_foobar" } }
      user.reload

      expect(response).to redirect_to(login_path)
      expect(user.valid_password?("new_foobar")).to be(true)
      expect(user.reset_password_token).to be_nil
    end

    it "redirects to login path if token is invalid" do
      put password_reset_path("bad token"), params: { user: { password: "foobar", password_confirmation: "foobar" } }

      expect(response).to redirect_to(login_path)
    end
  end
end
