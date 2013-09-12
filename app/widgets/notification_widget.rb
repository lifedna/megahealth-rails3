class NotificationWidget < AuthorizableWidget
  responds_to_event :read

  def display
  	@notifications = current_user.notifications_received.limit(3)
    render
  end

  def read
  	@notifications = current_user.notifications_received.limit(3)
  	@notifications.each do |n|
  	  n.read_message
  	  n.save
    end		
  	replace :view => :display
  	render :text => "$(\".unread-count\").remove();"
  end
end
