class Widget
  include Mongoid::Document	
  include Mongoid::Timestamps	

  before_create :default_values	

  field :name, type: String
  field :type, type: Integer
  field :position, type: Integer, default: 0

  belongs_to :section
  belongs_to :community

  def default_values
  end
end