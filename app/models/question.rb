class Question < Content

  field :anonymous, type: Boolean, default: false
  field :closed, type: Boolean, default: false
  field :closed_at, type: Time
  
  belongs_to :qa
  belongs_to :community
end