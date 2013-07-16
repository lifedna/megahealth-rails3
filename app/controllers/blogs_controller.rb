class BlogsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  # impressionist :actions=>[:show]

  def new
    @blog = Blog.new
  end

  def create
    if current_user.blogs.create(params[:blog])
      flash[:notice] = "Article has been created."
      redirect_to mine_url
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
