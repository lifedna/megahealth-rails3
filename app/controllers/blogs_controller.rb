class BlogsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  # impressionist :actions=>[:show]

  def index
    @phr = Phr.find params[:phr]
    @blogs = @phr.blogs
  end

  def new
    @phr = Phr.find params[:phr]
    @blog = Blog.new
  end

  def create
    if current_user.blogs.create(params[:blog])
      flash[:notice] = "Article has been created."
      redirect_to blogs_url(:phr => params[:blog]['phr_id'])
    end  
  end

  def show
    @blog = Blog.find params[:id]
    @phr = @blog.phr
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
