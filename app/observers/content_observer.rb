class ContentObserver < Mongoid::Observer
  def after_create(record)
  	user = record.user
  	case record.class.to_s.underscore
  	when 'video'
  	  user.publish_activity(:new_video, :object => record, :target_object => record.community)
  	when 'article'
  	  user.publish_activity(:new_article, :object => record, :target_object => record.community)
  	when 'poll'
  	  user.publish_activity(:new_poll, :object => record, :target_object => record.community)  
  	# when 'topic'  
  	#   user.publish_activity(:new_topic, :object => record, :target_object => record.community)	
  	# when 'question'  
  	#   user.publish_activity(:new_question, :object => record, :target_object => record.community)	  
  	end  
  end

  def before_destroy(record)
    case record.class.to_s.underscore
    when 'video'
      Activity.find_by(verb: :new_video, object: {"id" => record.id, "type"=>"Video"}).destroy
    when 'article'
      Activity.find_by(verb: :new_article, object: {"id" => record.id, "type"=>"Article"}).destroy
    when 'poll'
      Activity.find_by(verb: :new_poll, object: {"id" => record.id, "type"=>"Poll"}).destroy 
    end  
  end
end	