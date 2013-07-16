class Answer 
  include Mongoid::Document	
  include Mongoid::Timestamps

  field :content, type: String
  field :anonymous, type: Boolean, default: false
  field :rewarded, type: Boolean, default: false

  belongs_to :user
  belongs_to :question

end