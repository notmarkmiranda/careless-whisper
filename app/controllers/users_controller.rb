class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create token verify]

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_by!(phone_number: user_params[:phone_number])
    if @user.update(user_params)
      sms_service = SmsService.new
      sms_service.send_otp_code(@user)
      redirect_to user_token_path(token: @user.otp_secret_key)
    else
      render :new
    end
  end

  def token
    @user = User.find_by otp_secret_key: params[:token]
    not_found unless @user
  end

  def verify
    @user = User.find_by(otp_secret_key: params[:user_token])
    if @user&.authenticate_otp(params[:otp], drift: 90)
      session[:user_id] = @user.id
      redirect_to [:dashboard]
    else
      flash[:alert] = "Something went wrong. Please try again."
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :first_name, :last_name, :nickname)
  end
end
