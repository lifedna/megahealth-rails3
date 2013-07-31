# encoding: UTF-8
class Community
  include Mongoid::Document	
  include Mongoid::Timestamps

  field :name, type: String
  field :brief, type: String
  field :category, type: String
  field :online, type: Boolean, default: false
  field :offline_reason, type: String, default: "感谢访问，社群建设中"
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

  default_scope desc(:created_at)
  scope :category, ->(category){where(category: category)}

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

  def all_update
    hash = {"id"=>self.id, "type"=>"Community"}
    hash_array = []
    hash_array.push(hash)
    Activity.all_in(target_object: hash_array)
  end  
end