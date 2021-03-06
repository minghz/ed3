class PostsController < ApplicationController

  #http_basic_authenticate_with :name => "dhh", :password => "secret", :except => [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10, :order => "created_at DESC")
  
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @commentable = @post
    @comments = @commentable.comments
    @comment = Comment.new
  
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    if signed_in?
      @post = Post.new
    else
      flash[:error] = "Please sign in to post"
      redirect_to('/signin')
    end

    
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.create(params[:post])

    if @post.save
      flash[:success] = 'Post was successfully created.'
      redirect_to @post
    else
      render :new
    end

  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

      if @post.update_attributes(params[:post])
        flash[:success] = 'Post was successfully created.'
        redirect_to @post 
      else
        render action: "edit"
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_url
  end
end
