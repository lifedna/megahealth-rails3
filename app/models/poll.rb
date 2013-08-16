class Poll < Content

  field :active, type: Boolean, default: true
  field :multiple_allowed, type: Boolean, default: false
  field :max_answers, type: Integer
  field :end_at, type: Time
  # field :vote_count, type: Integer

  # validates :name, :presence => true

  has_many :options, :class_name => "PollOption", :dependent =>:delete, :autosave => true 
  accepts_nested_attributes_for :options, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  belongs_to :poll_set
  belongs_to :community

  def answered_by?(user)
    self.options.each do |option|
      answers = PollAnswer.where(:poll_option_id => option._id, :user_id => user.id)
      if answers.length > 0
        return true
        break
      end
    end  
    return false
  end

  def answers(user)
    opt_ids ||= []
    self.options.each do |option|
      opt_ids << option.id
    end

    answers = PollAnswer.where(user_id: user.id, :poll_option_id.in => opt_ids)
  end

  def answered_user_ids
    opt_ids ||= []
    self.options.each do |option|
      opt_ids << option.id
    end

    ids = PollAnswer.where(:poll_option_id.in => opt_ids).distinct(:user_id)
  end  

  def answers_count
    count = 0
    self.options.each do |option|
      count += option.poll_answers.size
    end
    return count
  end
end