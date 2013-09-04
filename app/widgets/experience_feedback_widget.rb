# encoding: UTF-8
class ExperienceFeedbackWidget < AuthorizableWidget
  responds_to_event :like 	
  responds_to_event :unlike
  responds_to_event :share 	
  responds_to_event :unshare

  def display(*args)
  	options = args.extract_options!
  	@instance = options[:instance]
    render
  end

  def like(evt)
  	@instance = Story.find evt[:id]
  	current_user.like @instance
  	replace :view => :display
  end

  def unlike(evt)
  	@instance = Story.find evt[:id]
  	current_user.unlike @instance
  	replace :view => :display
  end

  def share(evt)
  	@instance = Story.find evt[:id]
  	current_user.share @instance
  	replace :view => :display
  end

  def unshare(evt)
  	@instance = Story.find evt[:id]
  	current_user.unshare @instance
  	replace :view => :display
  end

end
