class Widgets::ForumsController < WidgetsController
  def show
  	@forum = Forum.find params[:id]
  	@community = Community.find params[:community_id]
  	@current_section = @forum.section
  	@sections = @community.sections
  end
end
