class Topic < Content
  field :sticky, type: Boolean, :default => false

  belongs_to :forum
  belongs_to :community
end