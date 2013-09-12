class Mongoid::CommentObserver < Mongoid::Observer
  def after_create(record)
  	author = record.commentabled_obj.user
  	author_hash = Hash.new
  	author_hash[:id] = author.id
  	author_hash[:type] = "User"
  	record.receivers << author_hash
  	record.save
  end
end