class WidgetListWidget < AuthorizableWidget
  responds_to_event :widgetAdded, :with => :process_add, :passing => :section	
  responds_to_event :widgetDeleted, :with => :process_delete, :passing => :section
  responds_to_event :sort, :with => :process_sort
    
  has_widgets do
    Section.find(params[:id]).widgets.each do |w|
      self << widget("widget_list/#{w.class.to_s.underscore}", "#{w.class.to_s.underscore}-#{w.id}", :widget => w)
    end
  end

  after_initialize do
    # @community = Community.find params[:community_id]
    @section = Section.find params[:id]
  end  

  def display(options)
    @section = options[:section]
    @widgets = @section.widgets
    render
  end

  def process_add(evt)
    w = evt[:widget]
    self << widget("widget_list/#{w.class.to_s.underscore}", "#{w.class.to_s.underscore}-#{w.id}", :widget => w)

    replace "##{widget_id} ul", {:state => :list}, w.section.widgets 
  end  

  def process_delete(evt)
    # @section = Section.find evt[:section_id]
    @section = evt[:section]
    @section.reload

    replace "##{widget_id} ul", {:state => :list}, @section.widgets
  end

  def list(widgets)
    render :locals => {:widgets => widgets}
  end 

  def process_sort(evt)
    # render :text => "alert(\'#{evt[:widget].count}\')"
    evt[:widget].each_with_index do |id, index|
      @section.widgets.where(id: id).update_all(position: index+1)
    end
  end
end
