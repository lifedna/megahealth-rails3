# encoding: UTF-8
class ShareWidget < AuthorizableWidget
  responds_to_event :recommend 	
  responds_to_event :unrecommend 		
  
  def display(*args)
  	options = args.extract_options!
  	@instance = options[:instance]
    render
  end

  def recommend 	(evt)
  	klass = evt[:klass]
  	id = evt[:id]
  	@instance = klass.constantize.find id
  	current_user.share @instance
  	replace :view => :display
  end

  def unrecommend (evt)
  	klass = evt[:klass]
  	id = evt[:id]
  	@instance = klass.constantize.find id
  	current_user.unshare @instance
  	replace :view => :display
  end
end