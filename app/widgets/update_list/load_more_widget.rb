class UpdateList::LoadMoreWidget < AuthorizableWidget
  responds_to_event :more, :with => :process_more

  def display(*args)
    options = args.extract_options!
  	@page_num = options[:page_num]
  	render unless @page_num.nil?    
  end

  def process_more(evt)
  	communities = current_user.communities
    @activities = Activity.all_update(communities).page evt[:page]

    unless @activities.last_page?
      page = @activities.current_page + 1
    else
      page = nil	
    end

    replace({:state => :display}, :page_num => page )	
  end

end
