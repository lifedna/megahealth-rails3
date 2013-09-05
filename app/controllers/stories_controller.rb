# encoding: UTF-8
class StoriesController < ContentController
  has_widgets do |root|
    root << widget(:experience_feedback)
  end

  def index
  	@issue = Issue.find params[:issue_id]
    if params[:scope].nil?
      scope = :newest 
    else
      scope = params[:scope]
    end

  	case params[:category]
  	when nil
      @stories = Story.where(issue_id: @issue.id).send("#{scope}").page params[:page]
  	when '就医'	
      @stories = Story.where(issue_id: @issue.id, category: '就医').send("#{scope}").page params[:page]
  	when '治疗'
      @stories = Story.where(issue_id: @issue.id, category: '治疗').send("#{scope}").page params[:page]
  	when '治愈'
      @stories = Story.where(issue_id: @issue.id, category: '治愈').send("#{scope}").page params[:page]
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

  def edit
    @story = Story.find params[:id]
    @issue = Issue.find params[:issue_id]
  end

  def update
    @story = Story.find params[:id]

    if @story.update_attributes(params[:story]) 
      flash[:notice] = "Topic has been updated."  
      redirect_to action => :show
    else
      flash[:notice] = "Failed to save blog."    
    end 
  end

  def destroy
    @story = Story.find params[:id]
    issue = @story.issue
    @story.destroy
    redirect_to issue_stories_path(issue)
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
