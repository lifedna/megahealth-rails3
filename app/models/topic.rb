class Topic < Content
  field :sticky, type: Boolean, :default => false
  field :posts_count, type: Integer, :default => 0

  belongs_to :forum
  belongs_to :community
  # has_many :posts

end