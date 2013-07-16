# encoding: UTF-8
class Bulletin < Widget
  include Mongoid::Document	
  include Mongoid::Timestamps

  field :body, type: String

  def default_values
  	community = Community.find self.community_id
  	self.name = community.name + "的公告栏"   	
  end

end