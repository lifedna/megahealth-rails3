class AddWidgetsWidget < Apotomo::Widget
  responds_to_event :new_widget	

  has_widgets do
    self << widget("section/setting", :section_setting, :section => @section)
  end

  def display(options)
  	@section = options[:section]
    render
  end
  
  def new_widget(evt)
  	section = Section.find evt[:id]
    class_name = evt[:category].to_s.camelize
    widget = class_name.constantize.create(:community_id => section.community.id, :section_id => section.id)
  	trigger :widgetAdded, :widget => widget
  end

end
