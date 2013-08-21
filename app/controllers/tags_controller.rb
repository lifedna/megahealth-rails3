class TagsController < ApplicationController
  before_filter :authenticate_user!

  has_widgets do |root|    
    root << widget(:content_list)
  end

  def index
  	
  end
end