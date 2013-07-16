class WidgetList::QaWidget < AuthorizableWidget
  responds_to_event :delete_widget, :with => :destroy

  def display
  	@qa = options[:widget]
    render
  end

  def destroy(evt)
  	# section_id = Announcement.find(evt[:widget_id]).section.id
    section = Qa.find(evt[:widget_id]).section
  	Qa.find(evt[:widget_id]).destroy
  	trigger :widgetDeleted, :section => section
  end

end
