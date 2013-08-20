class BlogsController < ContentController
  before_filter :authenticate_user!, :except => [:show]
  
  # has_widgets do |root|
  #   root << widget(:like)
  # end
  
  def index
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

  def edit
    @blog = Blog.find params[:id]
  end

  def update
    @blog = Blog.find params[:id]

    if @blog.update_attributes(params[:blog]) 
      flash[:notice] = "Topic has been updated."  
      redirect_to action => :show
    else
      flash[:notice] = "Failed to save blog."    
    end 
  end

  def destroy
    @blog = Blog.find params[:id]
    @blog.destroy
    redirect_to blogs_path
  end

  def comment
    @blog = Blog.find params[:id]
    if current_user.comment_on(@blog, params[:comment])
      redirect_to :action => "show"
    else
      flash[:notice] = "Comment save failed!"
    end     
  end

  def remove_comment
    if current_user.delete_comment(params[:comment_id])
      redirect_to :action => "show"
    end
  end
end
