class ContentController < ApplicationController
  before_filter :authenticate_user!

  has_widgets do |root|
    root << widget(:tags)
    root << widget(:like)
  end
  
end
