class ContentList::LoadMoreWidget  < AuthorizableWidget
  responds_to_event :more, :with => :process_more

  after_initialize do
    @klass = current_user.content_filter.merged_klass
    @keywords = current_user.content_filter.merged_keywords
    @scope = current_user.content_filter.scope
  end 

  def display(*args)
    options = args.extract_options!
  	@page_num = options[:page_num]
    @category = options[:category]
  	render unless @page_num.nil?    
  end

  def process_more(evt)

    if evt[:content_category]
      if @keywords.nil? or @keywords.empty?
        @items = Content.send("#{@scope}").in(_type: @klass).where(category: evt[:content_category]).page evt[:page]
      else
        @items = Content.send("#{@scope}").in(_type: @klass).where(category: evt[:content_category]).full_text_search(@keywords).page evt[:page]
      end  
    else
      if @keywords.nil? or @keywords.empty?
        @items = Content.send("#{@scope}").in(_type: @klass).all.page evt[:page]
      else
        @items = Content.send("#{@scope}").in(_type: @klass).all.full_text_search(@keywords).page evt[:page]
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
