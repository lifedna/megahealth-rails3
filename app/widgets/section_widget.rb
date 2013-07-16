class SectionWidget < Apotomo::Widget

  has_widgets do
    self << widget(:add_widgets)
    self << widget(:widget_list)
  end

  def display
    @section = Section.find params[:id]
    render
  end  

end
