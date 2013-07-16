# encoding: UTF-8
class Section
  include Mongoid::Document	
  include Mongoid::Timestamps

  before_create :default_values

  field :name, type: String, default: "未命名"

  validates :name, :presence => true

  has_many :widgets, :order => "position asc"
  belongs_to :community

  def default_values
  	self.name = "未命名"   	
  end

end