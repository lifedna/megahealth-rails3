class CommunityListWidget < AuthorizableWidget
  responds_to_event :newCommunity, :with => :process_add, :passing => :root	

  def display
  	@communities = Community.all
    render
  end

  def process_add(evt)
  	replace :state => :display	
  end

end
