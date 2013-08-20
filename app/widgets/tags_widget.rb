class TagsWidget < AuthorizableWidget
  responds_to_event :add_tag 	
  responds_to_event :remove_tag	
  responds_to_event :new_tag	

  def display(*args)
  	options = args.extract_options!
  	@content = options[:content]
  	@tags = @content.model_tags
    render
  end

  def list(tags)
  	render :locals => {:tags => tags}
  end

  def add_tag(evt)
  	@content = Content.find(evt[:content_id])
  	current_user.tag_on(@content, evt[:tag])
  	@tags = @content.model_tags
  	replace :view => :display
  end

  def remove_tag(evt)
  	@content = Content.find(evt[:content_id])
  	current_user.delete_tag(@content, evt[:tag])
  	@tags = @content.model_tags
  	replace :view => :display
  end

  def new_tag(evt)
  	@content = Content.find(evt[:content_id])
  	current_user.tag_on(@content, evt[:tag])
  	@tags = @content.model_tags
  	replace :view => :display
  end
end
