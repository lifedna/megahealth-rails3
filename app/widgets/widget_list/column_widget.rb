class WidgetList::ColumnWidget < AuthorizableWidget
  responds_to_event :delete_widget, :with => :destroy
  include ApplicationHelper
  helper_method :first_image_url

  def display
  	@column = options[:widget]
    render
  end
  
  def destroy(evt)
    section = Column.find(evt[:widget_id]).section
  	Column.find(evt[:widget_id]).destroy
  	trigger :widgetDeleted, :section => section
  end
end
