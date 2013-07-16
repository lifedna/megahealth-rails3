# encoding: UTF-8
class PollSet < Widget
  include Mongoid::Document

  field :display_counts, type: Integer

  has_many :polls, dependent: :delete do
    def find_by_id(id)
      where(_id: id).first
    end

    def active_polls
      where(active: true)
    end
  end

  belongs_to :user

  def default_values
    community = Community.find self.community_id
    self.name = community.name + "的投票"    
  end
end