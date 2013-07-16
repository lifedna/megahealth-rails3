class Phr::ConditionWidget < AuthorizableWidget
  responds_to_event :show, :with => :process_show

  helper ApplicationHelper

  def display(*args)
  	options = args.extract_options!
  	@condition = options[:instance]
    render
  end

  def process_show(evt)
  	phr = Phr.find evt[:phr_id]
  	@condition = phr.conditions.find(evt[:id])
  	replace :view => :display
  end
end
