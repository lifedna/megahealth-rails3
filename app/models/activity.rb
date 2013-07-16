class Activity
  include Streama::Activity

  activity :new_article do 
    actor :user
    object :article
    target_object :community
  end

  activity :new_question do 
    actor :user
    object :question
    target_object :community
  end

  activity :new_topic do 
    actor :user
    object :topic
    target_object :community
  end

  activity :new_poll do 
    actor :user
    object :poll
    target_object :community
  end

  activity :new_comment do 
    actor :user
    object :'mongoid/comment'
    target_object :community
  end

  activity :join do
    actor :user
    object :community
    target_object :community
  end

  activity :leave do
    actor :user
    object :community
    target_object :community
  end  
    
  def the_actor
    actor["type"].to_s.constantize.find_by(id: actor["id"])
  end  

  def the_object
    object["type"].to_s.constantize.find_by(id: object["id"])
  end

  def the_target
    target_object["type"].to_s.constantize.find_by(id: target_object["id"])
  end
end