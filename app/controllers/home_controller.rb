class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :communities]

  has_widgets do |root|    
    root << widget(:update_list) 
    root << widget(:content_list)
  end

  def index
    @users = User.all
  end

  def update
  end
  
  def features   
    @content_filter = current_user.content_filter
    # @keywords = current_user.content_filter.merged_keywords

    # if params[:category]
    #   if @keywords.nil? or @keywords.empty?
    #     @items = Content.where(category: params[:category])
    #   else
    #     @items = Content.where(category: params[:category]).full_text_search(@keywords)
    #   end  
    # else
    #   if @keywords.nil? or @keywords.empty?
    #     @items = Content.all
    #   else
    #     @items = Content.all.full_text_search(@keywords)
    #   end 
    # end   
  end

  def healthportal
    if params[:phr]
      @phr = Phr.find params[:phr]
    else
      @phr = current_user.phrs.first
    end
    @condition = @phr.conditions.build
    @symptom = @phr.symptoms.build
    @treatment = @phr.treatments.build
  end	

  def profile
  end

  def account
  end
end
