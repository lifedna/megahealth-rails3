class WidgetList::PollSetWidget < AuthorizableWidget
  responds_to_event :delete_widget, :with => :destroy	

  def display
  	@poll_set = options[:widget]
  	render
  end

  def destroy(evt)
    section = PollSet.find(evt[:widget_id]).section
  	PollSet.find(evt[:widget_id]).destroy
  	trigger :widgetDeleted, :section => section
  end

end
