class Phr::ConditionWidget < AuthorizableWidget
  responds_to_event :show, :with => :process_show

  helper ApplicationHelper

  def display(*args)
  	options = args.extract_options!
  	@condition = options[:instance]
    @communities = Community.where(conditions: @condition.name)
    render
  end

  def process_show(evt)
  	phr = Phr.find evt[:phr_id]
  	@condition = phr.conditions.find(evt[:id])
    @communities = Community.where(conditions: @condition.name)
  	replace :view => :display
  end
end
