class BlogsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  has_widgets do |root|
    root << widget(:like)
  end
  
  def index
    # @user = User.find params[:id]
    # @blogs = @user.blogs
    @blogs = current_user.blogs
  end

  def new
    @blog = Blog.new
  end

  def create   
    @blog = Blog.new(params[:blog]) 
    if @blog.save
      flash[:notice] = "Article has been created."
      redirect_to "/dashboard/blogs"
    else
      flash[:notice] = @blog.errors.to_s
      render :action => "new"  
    end  
  end

  def show
    @blog = Blog.find params[:id]
    @comment = @blog.comments.build
    @user = @blog.user
    @blogs = @blog.user.blogs

    impressionist @blog, nil, :unique => [:session_hash]
  end

  def comment
    @blog = Blog.find params[:id]
    if current_user.comment_on(@blog, params[:comment])
      redirect_to :action => "show"
    else
      flash[:notice] = "Comment save failed!"
    end     
  end

  def update
  end

  def destroy
  end
end
