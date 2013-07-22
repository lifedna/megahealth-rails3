class Activity
  include Streama::Activity

  paginates_per 5

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

  scope :update_by_user, where({'target_object.id' => '51e37648f9dffb5e4c000013', 'target_object.type' => 'Community'})
    
  def the_actor
    actor["type"].to_s.constantize.find_by(id: actor["id"])
  end  

  def the_object
    object["type"].to_s.constantize.find_by(id: object["id"])
  end

  def the_target
    target_object["type"].to_s.constantize.find_by(id: target_object["id"])
  end


  def self.all_update(communities)
    hash_array = []
    communities.each do |c|
      hash = {"id"=>c.id, "type"=>"Community"}    
      hash_array.push(hash)
    end
    Activity.in(target_object: hash_array).desc(:created_at)
  end
end