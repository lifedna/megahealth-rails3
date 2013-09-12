class Mongoid::CommentObserver < Mongoid::Observer
  def after_create(record)
  	if record.commenter != record.commentabled_obj.user
	  	notification = Notification.new
	  	notification.verb = "new_comment"
	  	notification.sender = record.commenter
	  	notification.receiver = record.commentabled_obj.user
	  	notification.notifiable = record.commentabled_obj
	  	notification.save
	end
  end
end