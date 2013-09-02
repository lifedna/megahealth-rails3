# encoding: UTF-8
class StoriesController < ContentController
  def index
  	@issue = Issue.find params[:issue_id]
  	case params[:category]
  	when nil
  	  @stories = @issue.stories
  	when '就医经历'	
  	  @stories = @issue.stories.where(category: '就医经历')
  	when '治疗经历'
  	  @stories = @issue.stories.where(category: '治疗经历')
  	when '治愈心得'
  	  @stories = @issue.stories.where(category: '治愈心得')
  	end	
  end

  def new
  	@issue = Issue.find params[:issue]
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
end
