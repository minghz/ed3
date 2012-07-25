class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Ed3"
      redirect_to @user, notice: 'Welcome to Ed3!'
    else 
      render 'new'
    end
  end
end
