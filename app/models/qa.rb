# encoding: UTF-8
class Qa < Widget
  field :name, type: String
  field :limits, type: Integer, default: 30

  def default_values
  	community = Community.find self.community_id
  	self.name = community.name + "的问答"   	
  end

  has_many :questions

end