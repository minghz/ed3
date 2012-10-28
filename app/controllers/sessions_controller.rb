class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      #succecefful sign in
      sign_in user
      redirect_back_or user
  
    else
      #something went wrong, re-render the sign up form
      flash[:error] = 'Invalid email/password combination'
      redirect_to '/signin'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end


end
