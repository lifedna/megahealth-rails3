class WidgetList::ForumWidget < AuthorizableWidget
  responds_to_event :delete_widget, :with => :destroy	

  def display(options)
  	@forum = options[:widget]
    render
  end

  def destroy(evt)
  	# section_id = Announcement.find(evt[:widget_id]).section.id
    section = Forum.find(evt[:widget_id]).section
  	Forum.find(evt[:widget_id]).destroy
  	trigger :widgetDeleted, :section => section
  end

end
