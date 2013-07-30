class ContentListWidget < AuthorizableWidget
  responds_to_event :more, :with => :process_more

  include ActionView::Helpers::JavaScriptHelper
  include ApplicationHelper
  helper_method :present, :first_image_url

  has_widgets do
    self << widget("content_list/load_more", :load_more_content)
  end

  after_initialize do
    @klass = current_user.content_filter.merged_klass
    @keywords = current_user.content_filter.merged_keywords
  end 

  def display(*args)
  	options = args.extract_options!
  	@category = options[:category]

    if @category
      if @keywords.nil? or @keywords.empty?
        @items = Content.in(_type: @klass).where(category: @category).page params[:page]
      else
        @items = Content.in(_type: @klass).where(category: @category).full_text_search(@keywords).page params[:page]
      end  
    else
      if @keywords.nil? or @keywords.empty?
        @items = Content.in(_type: @klass).all.page params[:page]
      else
        @items = Content.in(_type: @klass).all.full_text_search(@keywords).page params[:page]
      end 
    end 
    render
  end

  def process_more(evt)
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

    render :text => "$(\"##{widget_id}\").append(\"#{escape_javascript render({:state => :list}, @items)}\");"
  end

  def list(items)
  	render :locals => {:items => items}
  end

end
