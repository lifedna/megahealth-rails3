class Poll
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :details, type: String
  field :active, type: Boolean, default: true
  field :single_anwser, type: Boolean, default: true
  field :end_at, type: Time

  validates :name, :presence => true

  has_many :options, :class_name => "PollOption", :dependent =>:delete, :autosave => true  do
    def find_by_id(id)
      where(_id: id).first
    end
  end
  accepts_nested_attributes_for :options, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  belongs_to :poll_set
  belongs_to :community

end