class Widgets::TopicsController < ApplicationController
  has_widgets do |root|
    root << widget(:like)
  end
  
  def new
  	@forum = Forum.find params[:forum_id]
  	@topic = Topic.new
  end

  def create
  	@forum = Forum.find params[:forum_id]
  	@topic = Topic.new(params[:topic])
  	if @topic.save 
  	  flash[:notice] = "Topic saved successfully."
      redirect_to community_section_path(@forum.community, @forum.section)
  	else
  	  flash[:notice] = "Failed to save topic."	  
  	  render :action => :new
  	end
  end	

  def show
    @topic = Topic.find params[:id]
    @community = Community.find params[:community_id]
    @current_section = @topic.forum.section
    @sections = @community.sections

    impressionist @topic, nil, :unique => [:session_hash]
  end

  def edit
    @topic = Topic.find params[:id]
    @community = Community.find params[:community_id]
    @forum = Forum.find params[:forum_id]
    @current_section = @topic.forum.section
    @sections = @community.sections
  end

  def update
  	@topic = Topic.find params[:id]

  	if @topic.update_attributes(params[:topic])	
  	  flash[:notice] = "Topic has been updated."	
  	  redirect_to show_community_topic_path(@topic.community, @topic)
  	else
  	  flash[:notice] = "Failed to save topic."	  
  	end	
  end	

  def destroy
    @topic = Topic.find params[:id]
    forum = @topic.forum
    community = @topic.community
    @topic.destroy
    redirect_to show_community_forum_path(community, forum)
  end	

  def comment
    @topic = Topic.find params[:id]
    @comment = current_user.comment_on(@topic, params[:comment])
    if @comment.persisted?
      # current_user.publish_activity(:new_comment, :object => @comment, :target_object => @topic.forum.community)
      redirect_to :action => "show"
    else
      flash[:notice] = "Comment save failed!"
    end  
  end

  def remove_comment
    if current_user.delete_comment(params[:comment_id])
      redirect_to :action => "show"
    end
  end
end