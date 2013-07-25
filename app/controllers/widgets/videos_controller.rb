class Widgets::VideosController < ApplicationController
  def index
    @videos = VideoList.find(params[:video_list_id]).videos 
  end

  def new    
    @video_list = VideoList.find(params[:video_list_id])
    @video = Video.new
  end

  def create
    @video_list = VideoList.find(params[:video_list_id])
    if Video.create(params[:video])
      # current_user.publish_activity(:new_poll, :object => @poll, :target_object => @poll_set.community)
      redirect_to community_section_path(@video_list.community, @video_list.section) 
    else  
      render :action => "new"
    end
  end

  def show
    @video = Video.find params[:id]
    @community = Community.find params[:community_id]
    @current_section = @video.video_list.section
    @sections = @community.sections
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:poll])
      # redirect_to @poll, :notice  => "Successfully updated survey."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    # redirect_to surveys_url, :notice => "Successfully destroyed survey."
  end

  def comment
    @video = Video.find params[:id]
    @comment = current_user.comment_on(@video, params[:comment])
    if @comment.persisted?
      current_user.publish_activity(:new_comment, :object => @comment, :target_object => @video.video_list.community)
      redirect_to :action => "show"
    else
      flash[:notice] = "Comment save failed!"
    end  
  end
end
