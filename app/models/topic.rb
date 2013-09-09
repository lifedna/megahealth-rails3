class Topic < Content
  field :sticky, type: Boolean, :default => false

  belongs_to :forum
  belongs_to :community

  def last_updated_at
    if self.comments_count > 0
      self.comments.last.created_at
    else
      self.created_at
    end
  end
end