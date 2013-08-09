class Question < Content

  field :anonymous, type: Boolean, default: false
  field :closed, type: Boolean, default: false
  field :closed_at, type: Time
  

  has_many :answers
  belongs_to :qa
  belongs_to :community
end