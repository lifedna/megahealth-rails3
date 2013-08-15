# encoding: UTF-8
class Column < Widget
  field :name, type: String
  field :limits, type: Integer, default: 10  

  def default_values
  	community = Community.find self.community_id
  	self.name = community.name + "的专栏"   	
  end

  has_many :articles

end