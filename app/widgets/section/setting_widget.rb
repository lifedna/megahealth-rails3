class Section::SettingWidget < Apotomo::Widget
  responds_to_event :submit

  def display(options = {})
  	@section = options[:section]
    render
  end

  def submit(evt)
    @section = Section.find evt[:id]
  	if @section.update_attributes(evt[:section])
  	  trigger :updateName, :section => @section	
  	end
  end

end
