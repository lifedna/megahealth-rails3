class Widgets::QuestionsController < ContentController
  # has_widgets do |root|
  #   root << widget(:like)
  # end
  
  def new
    @qa = Qa.find params[:qa_id]
    @question = Question.new
    @question.title = params[:title]
    @community = Community.find params[:community_id]
    @sections = @community.sections
    @current_section = @qa.section
  end

  def create
    @qa = Qa.find params[:qa_id]
    @question = Question.new(params[:question])
    if @question.save 
      flash[:notice] = "Question saved successfully."
      redirect_to community_section_path(@qa.community, @qa.section)
    else
      flash[:notice] = "Failed to save question."    
      render :action => :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @community = Community.find params[:community_id]
    @sections = @question.community.sections
    @current_section = @question.qa.section

    impressionist @question, nil, :unique => [:session_hash]
  end

  # def answer
  #   @question = Question.find params[:id]
  #   @answer = @question.answers.build(:content => params[:answer])
  #   if @answer.save
  #     current_user.answers << @answer
  #     redirect_to :action => "show"
  #   else
  #     flash[:notice] = "Comment save failed!"
  #   end  
  # end

  def update
  end

  def destroy
  end

  def comment
    @question = Question.find params[:id]
    @comment = current_user.comment_on(@question, params[:comment])
    if @comment.persisted?
      # current_user.publish_activity(:new_comment, :object => @comment, :target_object => @question.qa.community)
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
