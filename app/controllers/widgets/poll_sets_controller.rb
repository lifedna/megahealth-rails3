class Widgets::PollSetsController < WidgetsController
  def show
  	@poll_set = PollSet.find params[:id]
  	@community = Community.find params[:community_id]
  	@current_section = @poll_set.section
  	@sections = @community.sections
  end	
end
