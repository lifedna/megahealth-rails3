class NewCommunityWidget < AuthorizableWidget
  responds_to_event :submit		

  def display
    render
  end

  def submit(evt)
  	# community = Community.create(evt[:community])
  	community = Community.new(evt[:community])
  	community.owner = current_user
    community.users << current_user
  	community.save!
    # current_user.publish_activity(:join, :object => community, :target_object => community)
  	trigger :newCommunity, :task => community
  	replace :view => :display
  end
end
