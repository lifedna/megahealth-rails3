# coding: utf-8
class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :communities]

  has_widgets do |root|    
    root << widget(:update_list) 
    root << widget(:content_list)
  end

  def explore   
    # redirect_to guide_path
    if current_user.last_sign_in_at.nil?
      redirect_to guide_path
    else
      @content_filter = current_user.content_filter  

      if session[:first_visit]
        session[:first_visit] = "false"
      else
        session[:first_visit] = "true"
      end
    end
  end

  def experiences
    if params[:alphabet]
      @issues = Issue.alphabet(params[:alphabet]).all
    else
      @issues = Issue.all
    end
  end

  def guide
    @content_filter = current_user.content_filter 
  end

  def dashboard
    @communities = current_user.communities
  end	

  def profile
  end

  def account
  end

  def search
    if params[:q]
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
    
    if params[:tag]
      @entries = Content.with_tag(params[:tag])

      if params[:category]
        if params[:type]
          @results = Content.with_tag(params[:tag]).where(_type: params[:type], category: params[:category])
        else
          @results = Content.with_tag(params[:tag]).where(category: params[:category])
        end
      else
        if params[:type]
          @results = Content.with_tag(params[:tag]).where(_type: params[:type])
        else
          @results = Content.with_tag(params[:tag])
        end
      end   

      @category_entries = Content.with_tag(params[:tag]).where(category: params[:category])

    end
  end
end
