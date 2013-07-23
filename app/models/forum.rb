# encoding: UTF-8
class Forum < Widget
  field :name, type: String
  field :limit, type: Integer

  def default_values
  	community = Community.find self.community_id
  	self.name = community.name + "的论坛"   	
  end

  has_many :topics
  has_many :posts
end	