class Post
  include Mongoid::Document	
  include Mongoid::Timestamps

  field :body, type: String

  validates :body, :presence => true
  # attr_accessible :body

  # belongs_to :forum
  belongs_to :topic
  belongs_to :user
  belongs_to :community

  before_save :topic_locked?

  private
    def topic_locked?
      if topic.locked?
        return false
      end  
    end
end