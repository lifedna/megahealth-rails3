class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :communities]

  def index
    @users = User.all
  end

  def update
    if user_signed_in?
      @activities ||= []
      current_user.communities.each do |community|
        # @activities.concat(community.activities_since_jion(current_user))
        @activities.concat(community.activities)

      end 
      @activities.sort_by!{|i| i.created_at}.reverse! unless @activities.empty?
    end
  end
  
  def features
    @feature_filter = current_user.feature_filter
    @keywords = current_user.feature_filter.merged_keywords
    @items ||= []
    if params[:category]
      @blogs = Blog.where(category: params[:category]).full_text_search(@keywords)
      @articles = Article.where(category: params[:category]).full_text_search(@keywords)
      @topics = Topic.where(category: params[:category]).full_text_search(@keywords)
    else
      @blogs = Blog.all.full_text_search(@keywords)
      @articles = Article.all.full_text_search(@keywords)
      @topics = Topic.all.full_text_search(@keywords)
    end  
    @items.concat(@blogs)
    @items.concat(@articles)
    @items.concat(@topics)
  end

  def mine
    if params[:phr]
      @phr = Phr.find params[:phr]
    else
      @phr = current_user.phrs.first
    end
    @condition = @phr.conditions.build
    @symptom = @phr.symptoms.build
    @treatment = @phr.treatments.build
  end	
end
