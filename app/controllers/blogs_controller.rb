class BlogsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  # impressionist :actions=>[:show]

  def index
    @user = User.find params[:id]
    @blogs = @user.blogs
  end

  def new
    @blog = Blog.new
  end

  def create   
    @blog = Blog.new(params[:blog]) 
    if @blog.save
      flash[:notice] = "Article has been created."
      render :action => "show"
    else
      render :action => "new"  
    end  
  end

  def show
    @blog = Blog.find params[:id]
    @comment = @blog.comments.build
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
