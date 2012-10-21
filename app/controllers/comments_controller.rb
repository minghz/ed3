class CommentsController < ApplicationController
  
before_filter :load_commentable
before_filter :init
  
  def index
    @comments = @commentable.comments
  end

  def new
    #redirect_to @commentable
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])

    @comment.user_id = current_user.id
    #@comment.post_id = @id # post_id not used anymore, using polymorphic now
    @comment.commenter = current_user.name
    
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new #TODO redirect to original post 'posts/:id/'
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to posts_url
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def init
    @resource, @id = request.path.split('/')[1, 2]

  end
  # def load_commentable
  #   klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
  
#ORIGINAL--
#  def create
#      @post = Post.find(params[:post_id])
#      @comment = @post.comments.create(params[:comment])
#      #@comment = current_user.comments.create(params[:comment])
#      
#      redirect_to post_path(@post)
#    end
#
#  def destroy
#    @post = Post.find(params[:post_id])
#    @comment = @post.comments.find(params[:id])
#    @comment.destroy
#    redirect_to post_path(@post)
#  end



end
