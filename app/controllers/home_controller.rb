# coding: utf-8
class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :communities]

  has_widgets do |root|    
    root << widget(:update_list) 
    root << widget(:content_list)
  end

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
      if params[:type]
        @results = Content.where(_type: params[:type], category: params[:category]).full_text_search(keywords)
      else
        @results = Content.where(category: params[:category]).full_text_search(keywords)
      end
    else
      if params[:type]
        @results = Content.where(_type: params[:type]).full_text_search(keywords)
      else
        @results = Content.all.full_text_search(keywords)
      end
    end   

    @category_entries = Content.where(category: params[:category]).full_text_search(keywords)
    
  end
end
