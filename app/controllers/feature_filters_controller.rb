class FeatureFiltersController < ApplicationController
  before_filter :authenticate_user!
  
  def update
  	@filter = current_user.feature_filter
  	if @filter.update_attributes params[:feature_filter]
  	  redirect_to features_url
  	else
  	  redirect_to features_url	
  	end	
  end
end
