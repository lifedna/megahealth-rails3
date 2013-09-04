# encoding: UTF-8
class StoriesController < ContentController
  has_widgets do |root|
    root << widget(:experience_feedback)
  end

  def index
  	@issue = Issue.find params[:issue_id]
  	case params[:category]
  	when nil
  	  @stories = @issue.stories.page params[:page]
  	when '就医'	
  	  @stories = @issue.stories.where(category: '就医').page params[:page]
  	when '治疗'
  	  @stories = @issue.stories.where(category: '治疗').page params[:page]
  	when '治愈'
  	  @stories = @issue.stories.where(category: '治愈').page params[:page]
  	end	
  end

  def new
  	@issue = Issue.find params[:issue_id]
  	@story = @issue.stories.new
  end

  def create
  	@story = Story.new(params[:story]) 
    if @story.save
      flash[:notice] = "Story has been created."
      redirect_to issue_stories_path(@story.issue_id)
    else
      flash[:notice] = @story.errors.to_s
      render :action => "new"  
    end 
  end

  def show
    @story = Story.find params[:id]
    @issue = Issue.find params[:issue_id]
  end

  def comment
    @story = Story.find params[:id]
    if current_user.comment_on(@story, params[:comment])
      redirect_to :action => "show"
    else
      flash[:notice] = "Comment save failed!"
      redirect_to :action => "show"
    end     
  end

  def remove_comment
    if current_user.delete_comment(params[:comment_id])
      redirect_to :action => "show"
    end
  end
end
