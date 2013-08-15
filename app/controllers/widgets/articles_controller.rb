# 
class Widgets::ArticlesController < ApplicationController
  has_widgets do |root|
    root << widget(:like)
  end

  def new
    @column = Column.find params[:column_id]
    @article = Article.new
  end

  def create
    @column = Column.find params[:column_id]
    @article = Article.new(params[:article])
    if @article.save 
      flash[:notice] = "Article saved successfully."
      # current_user.publish_activity(:new_article, :object => @article, :target_object => @column.community)
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

    impressionist @article, nil, :unique => [:session_hash]
  end

  def edit
    @article = Article.find params[:id]
  end

  def comment
    @article = Article.find params[:id]
    comment = current_user.comment_on(@article, params[:comment])
    if comment.persisted?
      redirect_to :action => "show"
    else
      flash[:notice] = "Comment save failed!"
    end  
  end

  def update
    @article = Article.find params[:id]

    if @article.update_attributes(params[:article]) 
      flash[:notice] = "Topic has been updated."  
      redirect_to show_community_article_path(@article.community, @article)
    else
      flash[:notice] = "Failed to save article."    
    end 
  end

  def destroy
    @article = Article.find params[:id]
    column = @article.column
    community = @article.community
    @article.destroy
    redirect_to show_community_column_path(community, column)    
  end
end
