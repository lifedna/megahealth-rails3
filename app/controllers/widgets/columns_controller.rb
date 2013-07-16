class Widgets::ColumnsController < WidgetsController
  def show
  	@column = Column.find params[:id]
  	@community = Community.find params[:community_id]
  	@current_section = @column.section
  	@sections = @community.sections
  end	
end
