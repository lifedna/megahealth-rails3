class Widgets::BulletinsController < WidgetsController
  def edit
    @widget = Widget.find params[:id]
  	@community = Community.find params[:community_id]
  	@current_section = @widget.section
  	@sections = @community.sections
  end
end