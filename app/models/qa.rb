# encoding: UTF-8
class Qa < Widget
  include Mongoid::Document	
  include Mongoid::Timestamps

  field :name, type: String
  field :limit, type: Integer

  def default_values
  	community = Community.find self.community_id
  	self.name = community.name + "的问答"   	
  end

  has_many :questions

end