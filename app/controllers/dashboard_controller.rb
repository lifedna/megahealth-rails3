# encoding: UTF-8
class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    
  end

  def phrs
  	phr = current_user.phrs.first
  	redirect_to phr_path(phr)
  end

  def stars
    @contents = current_user.liked_objects - current_user.liked_blogs

    if params[:category]      
      @stared = @contents.select {|i| i.category == params[:category]}
    else
      @stared = @contents
    end
    return @stared
  end

  def blogs
    @blogs = current_user.blogs
  end
end