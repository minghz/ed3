class UsersController < ApplicationController
  
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  
  def show
    @user = User.find(params[:id])
  end

  def new
    unless signed_in?
      @user = User.new
    else
     redirect_to(root_path)
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Ed3"
      redirect_to @user
    else 
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page]) #paginate limit per_page defaults to 30
  end

  def destroy
    if User.find(params[:id]).admin?
      flash[:error] = "can't delete admin"
      redirect_to users_url
    else
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed"
      redirect_to users_url
    end
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
