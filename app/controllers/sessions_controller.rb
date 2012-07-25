class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      #succecefful sign in
      sign_in user
      redirect_to user
  
    else
      #something went wrong, re-render the sign up form
      flash.now[:error] = 'Invalid email/password combination'
      render 'new', notice: 'bad email and password'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end


end
