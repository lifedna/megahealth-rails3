class ContentList::LoadMoreWidget  < AuthorizableWidget
  responds_to_event :more, :with => :process_more

  def display(*args)
    options = args.extract_options!
  	@page_num = options[:page_num]
    @category = options[:category]
  	render unless @page_num.nil?    
  end

  def process_more(evt)
  	@feature_filter = current_user.feature_filter
    @keywords = current_user.feature_filter.merged_keywords

    if evt[:content_category]
      if @keywords.nil? or @keywords.empty?
        @items = Content.where(category: evt[:content_category]).page evt[:page]
      else
        @items = Content.where(category: evt[:content_category]).full_text_search(@keywords).page evt[:page]
      end  
    else
      if @keywords.nil? or @keywords.empty?
        @items = Content.all.page evt[:page]
      else
        @items = Content.all.full_text_search(@keywords).page evt[:page]
      end 
    end

    unless @items.last_page?
      page = @items.current_page + 1
    else
      page = nil	
    end

    replace({:state => :display}, :page_num => page, :category =>evt[:content_category])	
  end

end
