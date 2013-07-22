class UpdateListWidget < AuthorizableWidget
  responds_to_event :more, :with => :process_more

  include ActionView::Helpers::JavaScriptHelper
  include ApplicationHelper
  helper_method :present

  has_widgets do
    self << widget("update_list/load_more", :load_more)
  end

  def display
  	communities = current_user.communities
    @activities = Activity.all_update(communities).page params[:page]
    render
  end

  def process_more(evt)
  	communities = current_user.communities
    @activities = Activity.all_update(communities).page evt[:page] unless evt[:page].nil?

    render :text => "$(\"##{widget_id}\").append(\"#{escape_javascript render({:state => :list}, @activities)}\");"
  end

  def list(activities)
  	render :locals => {:activities => activities}
  end

end
