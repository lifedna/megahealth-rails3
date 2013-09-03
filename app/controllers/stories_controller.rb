# encoding: UTF-8
class StoriesController < ContentController
  def index
  	@issue = Issue.find params[:issue_id]
  	case params[:category]
  	when nil
  	  @stories = @issue.stories.page params[:page]
  	when '就医'	
  	  @stories = @issue.stories.where(category: '就医经历').page params[:page]
  	when '治疗'
  	  @stories = @issue.stories.where(category: '治疗经历').page params[:page]
  	when '治愈'
  	  @stories = @issue.stories.where(category: '治愈心得').page params[:page]
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
end
