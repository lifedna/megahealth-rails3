# encoding: UTF-8
class LikeWidget < AuthorizableWidget
  responds_to_event :like 	
  responds_to_event :unlike 	
  
  def display(*args)
  	options = args.extract_options!
  	@instance = options[:instance]
    text(@instance)
    render
  end

  def like(evt)
  	klass = evt[:klass]
  	id = evt[:id]
  	@instance = klass.constantize.find id
  	current_user.like @instance
    text(@instance)
  	replace :view => :display
  end

  def unlike(evt)
  	klass = evt[:klass]
  	id = evt[:id]
  	@instance = klass.constantize.find id
  	current_user.unlike @instance
    text(@instance)
  	replace :view => :display
  end

  private

  def text(instance)
    case instance.class.to_s
    when "Blog"
      @text  = "喜欢"
    when "Topic"
      @text  = "关注"  
    else
      @text = "收藏"
    end
  end
end
