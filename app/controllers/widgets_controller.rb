class WidgetsController < ApplicationController
  # before_filter :authenticate_user!, :only => :update

  def update
  	@widget = Widget.find params[:id]

  	if @widget.update_attributes(params[@widget.class.to_s.underscore.to_sym])	
  	  flash[:notice] = "Community has been updated."	
  	  redirect_to community_section_path(@widget.community, @widget.section)
  	end	
  end	
end