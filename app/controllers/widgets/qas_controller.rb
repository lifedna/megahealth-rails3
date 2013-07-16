class Widgets::QasController < WidgetsController
  def show
  	@qa = Qa.find params[:id]
  	@current_section = @qa.section
  	@community = Community.find params[:community_id]
  	@sections = @community.sections
  end
end