# 
class Widgets::ArticlesController < ApplicationController
  def new
    @column = Column.find params[:column_id]
    @article = Article.new
  end

  def create
    @column = Column.find params[:column_id]
    @article = Article.new(params[:article])
    if @article.save 
      flash[:notice] = "Article saved successfully."
      current_user.publish_activity(:new_article, :object => @article, :target_object => @column.community)
      redirect_to community_section_path(@column.community, @column.section)
    else
      flash[:notice] = "Failed to save article."    
      render :action => :new
    end
  end

  def show
    @article = Article.find params[:id]
    @community = Community.find params[:community_id]
    @current_section = @article.column.section
    @sections = @community.sections
  end

  def comment
    @article = Article.find params[:id]
    comment = current_user.comment_on(@article, params[:comment])
    if comment.persisted?
      # current_user.publish_activity(:new_comment, :object => comment, :target_object => @article.community)
      redirect_to :action => "show"
    else
      flash[:notice] = "Comment save failed!"
    end  
  end

  def update
    @widget = Widget.find params[:id]

    if @widget.update_attributes(params[@widget.class.to_s.camelize(:lower).to_sym])  
      flash[:notice] = "Community has been updated."  
      redirect_to community_section_path(@widget.community, @widget.section)
    else
      flash[:notice] = "Failed to save article."    
    end
  end

  def destroy
  end
end
