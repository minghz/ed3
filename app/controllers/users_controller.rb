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
      redirect_to @user, notice: 'User created. Welcome to ed3!'
    else 
      render 'new'
    end
  end
end
