class ContentFiltersController < ApplicationController
  before_filter :authenticate_user!
  
  def update
  	@filter = current_user.content_filter
  	if @filter.update_attributes params[:content_filter]
  	  redirect_to features_url
  	else
  	  redirect_to features_url	
  	end	
  end
end
