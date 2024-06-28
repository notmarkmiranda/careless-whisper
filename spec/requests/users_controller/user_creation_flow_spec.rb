require "rails_helper"

RSpec.describe "User Creation Flow", type: :request do
  describe "GET#new" do
    describe "as a visitor" do
      it "responds successfully" do
        get "/users/new"

        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    describe "as a user" do
      before { sign_in create(:user) }

      it "redirects to the dashboard" do
        get "/users/new"

        expect(response).to redirect_to dashboard_path
      end
    end
  end

  describe "POST#create" do
    describe "when a user does not exist" do
      it "creates a user" do
        allow(SmsService).to receive_message_chain(:new, :send_otp_code)

        expect do
          post "/users", params: {user: attributes_for(:user)}
        end.to change(User, :count).by(1)
      end
    end

    describe "when a user already exists" do
      let(:user) { create(:user) }

      it "does not create a user" do
        expect do
          expect do
            post "/users", params: {user: {phone_number: user.phone_number}}
          end.not_to change(User, :count)
        end
      end
    end
  end

  describe "GET#users/token/:user_id" do
    describe "when the user exists" do
      let(:user) { create(:user) }

      it "responds successfully" do
        get "/users/token/#{user.otp_secret_key}"

        expect(response).to have_http_status 200
      end
    end

    describe "when the user does not exist" do
      it "responds with a 404" do
        get "/users/token/0"

        expect(response).to have_http_status 404
      end
    end
  end

  describe "POST#users/verify" do
    let(:user) { create(:user) }

    describe "when the code is correct" do
      let!(:code) { user.otp_code }

      it "redirects to the dashboard" do
        post "/users/verify", params: {otp: code, user_token: user.otp_secret_key}

        expect(response).to redirect_to dashboard_path
      end
    end

    describe "when the code is incorrect" do
      it "does not redirect to the dashboard" do
        post "/users/verify", params: {otp: "0000", user_token: user.otp_secret_key}

        expect(response).not_to redirect_to dashboard_path
      end
    end
  end
end
