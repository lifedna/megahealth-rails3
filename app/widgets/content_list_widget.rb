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
    @tag = options[:tag]

    # if @category
    #   if @keywords.nil? or @keywords.empty?
    #     @items = Content.in(_type: @klass).send("#{@scope}").where(category: @category).page(1)
    #   else
    #     @items = Content.in(_type: @klass).send("#{@scope}").where(category: @category).full_text_search(@keywords).page(1)
    #   end  
    # else
    #   if @keywords.nil? or @keywords.empty?
    #     @items = Content.in(_type: @klass).send("#{@scope}").all.page(1)
    #   else
    #     @items = Content.in(_type: @klass).send("#{@scope}").all.full_text_search(@keywords).page(1)
    #   end 
    # end 

    @items = search(:klass => @klass, :keywords => @keywords, :scope => @scope, :category => @category, :tag => @tag, :num => 1)
    @last_page = @items.last_page? 
    render
  end

  def process_more(evt)
    # if evt[:content_category]
    #   if @keywords.nil? or @keywords.empty?
    #     @items = Content.in(_type: @klass).send("#{@scope}").where(category: evt[:content_category]).page evt[:page]
    #   else
    #     @items = Content.in(_type: @klass).send("#{@scope}").where(category: evt[:content_category]).full_text_search(@keywords).page evt[:page]
    #   end  
    # else
    #   if @keywords.nil? or @keywords.empty?
    #     @items = Content.in(_type: @klass).send("#{@scope}").all.page evt[:page]
    #   else
    #     @items = Content.in(_type: @klass).send("#{@scope}").all.full_text_search(@keywords).page evt[:page]
    #   end 
    # end

    @items = search(:klass => @klass, :keywords => @keywords, :scope => @scope, :category => evt[:content_category], :tag => evt[:tag], :num => evt[:page])
    @last_page = @items.last_page? 
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
    tag = options[:tag]
    keywords = options[:keywords]
    num = options[:page_num]

    if tag

      if category
        if keywords.nil? or keywords.empty?
          items = Content.in(_type: klass).with_tag(tag).send("#{scope}").where(category: category).page num
        else
          items = Content.in(_type: klass).with_tag(tag).send("#{scope}").where(category: category).full_text_search(keywords).page num
        end  
      else
        if keywords.nil? or keywords.empty?
          items = Content.in(_type: klass).with_tag(tag).send("#{scope}").all.page num
        else
          items = Content.in(_type: klass).with_tag(tag).send("#{scope}").all.full_text_search(keywords).page num
        end 
      end

    else

      if category
        if keywords.nil? or keywords.empty?
          items = Content.in(_type: klass).send("#{scope}").where(category: category).page num
        else
          items = Content.in(_type: klass).send("#{scope}").where(category: category).full_text_search(keywords).page num
        end  
      else
        if keywords.nil? or keywords.empty?
          items = Content.in(_type: klass).send("#{scope}").all.page num
        else
          items = Content.in(_type: klass).send("#{scope}").all.full_text_search(keywords).page num
        end 
      end

    end

  end  
end
