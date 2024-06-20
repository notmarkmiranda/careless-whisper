class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create token verify]

  def new
    @user = User.new
  end

  def create
  end

  def token
    @user = User.find_by otp_secret_key: params[:user_id]
  end

  def verify
  end
end
