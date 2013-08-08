class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :communities]

  has_widgets do |root|    
    root << widget(:update_list) 
    root << widget(:content_list)
  end

  # def index
  #   @users = User.all
  # end

  # def update
  # end
  
  def explore   
    @content_filter = current_user.content_filter  
    @hot_articles = Article.hot.limit(5)
    @hot_topics = Topic.hot.limit(5)
    @hot_blogs = Blog.hot.limit(5)
  end

  def dashboard
    @communities = current_user.communities
  end	

  def profile
  end

  def account
  end
end
