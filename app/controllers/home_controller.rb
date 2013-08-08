class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :communities]

  has_widgets do |root|    
    root << widget(:update_list) 
    root << widget(:content_list)
  end

  # def index
  #   @users = User.all
  # end

  # def update
  # end
  
  def explore   
    @content_filter = current_user.content_filter  
  end

  def dashboard
  end	

  def profile
  end

  def account
  end
end
