class RetrievalsController < ApplicationController

  def new
  end

  def create
    if params[:email] == ''
      flash[:error] = "please enter something"
      render :new
    else
      user = User.find_by_email(params[:email].downcase)
      if user != nil
        user.send_password_reset
        flash[:success] = "email sent with password reset to " + user.email
        redirect_to signin_url
      else
        flash[:error] = "this e-mail doesn't exist"
        render :new
      end
    
    end

  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Password reset has expired"
      redirect_to new_retrieval_path
    elsif @user.update_attributes(params[:user])
      flash[:success] = "password has been reset"
      redirect_to signin_url
    else
      render :edit
    end
  end


end
