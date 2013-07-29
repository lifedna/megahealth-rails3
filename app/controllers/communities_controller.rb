class CommunitiesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  has_widgets do |root|    
    root << widget(:new_community)
    root << widget(:community_list) 
    root << widget(:section_list, :community => @community)  
  end

  def index
    @my_communities = current_user.communities
  end

  def new
    @community = Community.new
  end

  def create
    community = Community.new(params[:community])
    community.owner = current_user
    community.users << current_user
    if community.save      
      flash[:notice] = "Community has been created."
      redirect_to communities_path
    end 
  end

  def show
  	@community = Community.find(params[:id])
  	@section = @community.sections.first
  	if @section.nil?
  	  if current_user == @community.the_owner
        redirect_to admin_community_url
      end
  	else
      redirect_to community_section_url(@community, @section)
      # redirect_to section_url(@section)
  	end
  end  

  def admin
  	@community = Community.find(params[:id])
  end

  def update
    @community = Community.find(params[:id])

    if @community.update_attributes(params[:community])
      flash[:notice] = "Community saved successfully."
    else
      flash[:notice] = "Community save failed."  
    end  
    render "admin"
  end

  def join
    @community = Community.find(params[:id])
    @community.users << current_user
    # @community.save
    current_user.publish_activity(:join, :object => @community, :target_object => @community)
    redirect_to community_path(@community)
  end

  def leave
    @community = Community.find(params[:id])
    @community.users.delete(current_user)
    current_user.publish_activity(:leave, :object => @community, :target_object => @community)
    # @community.save
    redirect_to community_path(@community)
  end
end
