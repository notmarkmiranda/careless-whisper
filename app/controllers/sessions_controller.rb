class SessionsController < ApplicationController
  def destroy
    session[:user_id] = nil
    redirect_to new_user_path
  end
end