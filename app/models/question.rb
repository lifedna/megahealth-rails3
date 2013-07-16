class Question 
  include Mongoid::Document	
  include Mongoid::Timestamps
  include Mongoid::Likeable
  include Mongoid::Search

  field :title, type: String
  field :body, type: String
  field :anonymous, type: Boolean, default: false
  field :category, type: Integer

  field :closed, type: Boolean, default: false
  field :closed_at, type: Time
  
  search_in :title, :body

  has_many :answers
  belongs_to :user
  belongs_to :qa
  belongs_to :community

  def liked?(user)
    return self.likers.include?(user)
  end 
end