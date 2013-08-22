class ContentListWidget < AuthorizableWidget
  responds_to_event :more, :with => :process_more

  include ActionView::Helpers::JavaScriptHelper
  include ApplicationHelper
  helper_method :present, :first_image_url

  has_widgets do
    self << widget("content_list/load_more", :load_more_link)
  end

  after_initialize do
    @klass = current_user.content_filter.merged_klass
    @keywords = current_user.content_filter.merged_keywords
    @scope = current_user.content_filter.scope
  end 

  def display(*args)
  	options = args.extract_options!
  	@category = options[:category]

    @items = search(:klass => @klass, 
                    :keywords => @keywords, 
                    :scope => @scope, 
                    :category => @category, 
                    :page_num => 1)

    render
  end

  def process_more(evt)
    @items = search(:klass => @klass, 
                    :keywords => @keywords, 
                    :scope => @scope, 
                    :category => evt[:content_category], 
                    :page_num => evt[:page])
    
    render :text => "$(\"##{widget_id}\").append(\"#{escape_javascript render({:state => :list}, @items)}\");"
  end

  def list(items)
  	render :locals => {:items => items}
  end


  private

  def search(*args)
    options = args.extract_options!
    category = options[:category]
    scope = options[:scope]
    klass = options[:klass]
    keywords = options[:keywords]
    page_num = options[:page_num]


    if category
      if keywords.nil? or keywords.empty?
        items = Content.in(_type: klass).send("#{scope}").where(category: category).page page_num
      else
        items = Content.in(_type: klass).send("#{scope}").where(category: category).full_text_search(keywords).page page_num
      end  
    else
      if keywords.nil? or keywords.empty?
        items = Content.in(_type: klass).send("#{scope}").all.page page_num
      else
        items = Content.in(_type: klass).send("#{scope}").all.full_text_search(keywords).page page_num
      end 
    end

  end  
end
