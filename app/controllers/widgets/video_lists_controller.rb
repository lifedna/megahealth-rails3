class Widgets::VideoListsController < WidgetsController
  def show
  	@video_list = VideoList.find params[:id]
  	@community = Community.find params[:community_id]
  	@current_section = @video_list.section
  	@sections = @community.sections
  end	
end
