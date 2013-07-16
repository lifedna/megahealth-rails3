class SectionsController < ApplicationController
  has_widgets do |root|
    root << widget(:section_list)
    root << widget(:section)
  end
  	
  def show
  	@section = Section.find(params[:id])
  	@community = @section.community
  end

  def create
  	community = Community.find params[:community_id]
  	section = community.sections.create
  	redirect_to community_section_path(community, section) 
  end	

  def destroy
  	c = Section.find(params[:id]).community
  	if Section.find(params[:id]).destroy
  	  redirect_to community_path(c)
  	end  	
  end	
end
