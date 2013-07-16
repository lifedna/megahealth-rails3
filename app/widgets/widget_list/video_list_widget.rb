class WidgetList::VideoListWidget < AuthorizableWidget
  responds_to_event :delete_widget, :with => :destroy

  def display
  	@video_list = options[:widget]
  	render
  end

  def destroy(evt)
    section = VideoList.find(evt[:widget_id]).section
  	VideoList.find(evt[:widget_id]).destroy
  	trigger :widgetDeleted, :section => section
  end

end
