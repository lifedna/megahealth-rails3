class SectionListWidget < AuthorizableWidget
  responds_to_event :updateName, :with => :update, :passing => :root	

  def display(options)
  	@community = options[:community]
  	@sections = @community.sections
    @current_section = options[:current_section]

    render
  end

  def update(evt)
  	id = evt[:section].id
  	name = evt[:section].name
  	render :text => "$(\"li.active a\").html(\"#{name} <span class='icon icon-16 icon-pencil background-grey'></span>\");"
  end	

end
