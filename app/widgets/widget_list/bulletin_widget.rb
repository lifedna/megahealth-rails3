class WidgetList::BulletinWidget < AuthorizableWidget
  responds_to_event :delete_widget, :with => :destroy

  def display(options)
  	@bulletin = options[:widget]
    render
  end

  def form
    render
  end

  def destroy(evt)
    section = Bulletin.find(evt[:widget_id]).section
  	Bulletin.find(evt[:widget_id]).destroy
  	trigger :widgetDeleted, :section => section
  end

end