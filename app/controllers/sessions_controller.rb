class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_helper
  end

  def destroy
    session[:user_id] = nil
    redirect_helper
  end
  
  def redirect_helper
    redirect_to root_path
  end
end
