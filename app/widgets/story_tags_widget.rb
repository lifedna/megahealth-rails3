class StoryTagsWidget < AuthorizableWidget
  responds_to_event :add_tag 	
  responds_to_event :remove_tag	
  responds_to_event :new_tag	

  def display(*args)
  	options = args.extract_options!
  	@story = options[:story]
  	@tags = @story.model_tags
    render
  end

  def list(tags)
  	render :locals => {:tags => tags}
  end

  def add_tag(evt)
  	@story = Story.find(evt[:story_id])
  	current_user.tag_on(@story, evt[:tag])
  	@tags = @story.model_tags
  	replace :view => :display
  end

  def remove_tag(evt)
  	@story = Story.find(evt[:story_id])
  	current_user.delete_tag(@story, evt[:tag])
  	@tags = @story.model_tags
  	replace :view => :display
  end

  def new_tag(evt)
  	@story = Story.find(evt[:story_id])
  	current_user.tag_on(@story, evt[:tag])
  	@tags = @story.model_tags
  	replace :view => :display
  end

end
