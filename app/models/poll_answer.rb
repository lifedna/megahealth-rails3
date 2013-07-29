class PollAnswer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :poll_option

  # scope :by_poll, ->(poll){where(:poll_option.in => poll.options)}
end