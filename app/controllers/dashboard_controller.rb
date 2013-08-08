class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def phrs
  	phr = current_user.phrs.first
  	redirect_to phr_path(phr)
  end

  def stars
    if params[:category]
      @contents = current_user.liked_objects - current_user.liked_blogs
      @contents.select! {|i| i.category == params[:category]}
    else
      @contents = current_user.liked_objects - current_user.liked_blogs
    end
  end

  def blogs
    @blogs = current_user.blogs
  end
end