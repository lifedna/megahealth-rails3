class Mongoid::CommentObserver < Mongoid::Observer
  def after_create(record)
  	if record.commenter != record.commentabled_obj.user
  	  notification = Notification.find_or_create_by(has_been_read:"unread", receiver:record.commentabled_obj.user, notifiable:record.commentable)
  	  notification.verb = "new_comment"
  	  notification.inc(:count, 1)
  	  notification.save
	end
  end
end