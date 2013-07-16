class Community
  include Mongoid::Document	
  include Mongoid::Timestamps

  field :name, type: String
  field :brief, type: String

  embeds_one :owner

  validates :name, :presence => true, :uniqueness => true

  has_and_belongs_to_many :users
  has_many :sections
  has_many :widgets
  has_many :articles
  has_many :questions  
  has_many :polls
  has_many :topics
  has_many :posts 

  def the_owner
    User.find_by(id: self.owner.id)
  end

  def activities
    Activity.where(target_object:{"id" => self.id, "type"=>"Community"})
  end

  def activities_since_jion(user)
    Activity.where(target_object:{"id" => self.id, "type"=>"Community"}, :created_at.gt => join_time(user))
  end

  def join_time(user)
    Activity.where(verb: :join, actor: {"id" => user.id, "type"=>"User"}, object: {"id" => self.id, "type"=>"Community"}).last.created_at
  end

  def leave_time(user)
    Activity.where(verb: :leave, actor: {"id" => user.id, "type"=>"User"}, object: {"id" => self.id, "type"=>"Community"}).last.created_at
  end
end