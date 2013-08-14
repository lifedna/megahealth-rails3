# coding: utf-8
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

  def search
    keywords ||= []
    keywords << params[:q]
    @entries = Content.all.full_text_search(keywords)

    if params[:category]
      category = params[:category]
    else
      category = '健康知识'
    end   

    @category_entries = Content.where(category: category).full_text_search(keywords)

    if params[:type]
      @results = Content.where(_type: params[:type]).where(category: category).full_text_search(keywords)
    else
      @results = Content.where(category: category).full_text_search(keywords)
    end
  end
end
