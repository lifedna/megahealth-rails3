# encoding: UTF-8
class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index    
  end

  def issues
    @phis = current_user.phis
    @stories = Story.all
    @stories.each do |s|
      issue = s.issue
      user = s.user
      phi = Phi.where(issue: issue, user: user).first
      s.phi = phi
      s.save
    end

    params[:name] ||= @phis.first.name
    @phi = Phi.find_by(name: params[:name])

    if params[:name]
      @phi = current_user.phis.where(name: params[:name]).first
      @stories = @phi.stories
    else
      @stories = current_user.stories
    end

    @commented_stories = Story.commented_by_user(current_user).select! {|s| s.issue == @phi.issue}
  end

  def phrs
  	phr = current_user.phrs.first
  	redirect_to phr_path(phr)
  end

  def stars
    # @contents = current_user.liked_objects - current_user.liked_blogs

    # if params[:category]      
    #   @stared = @contents.select {|i| i.category == params[:category]}
    # else
    #   @stared = @contents
    # end
    # return @stared
    if params[:tag]
      @tagged = current_user.find_tagged_objs_with(params[:tag])
    else
      @tagged = current_user.find_all_tagged_objs
    end
  end

  def blogs
    @blogs = current_user.blogs
  end
end