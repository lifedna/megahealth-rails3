class Conversation
  include Mongoid::Document
 
  has_many :messages, :dependent => :destroy
  has_and_belongs_to_many :participants, :class_name => "User"

  # validates :participants, :presence => true
  # validates :participants, :uniqueness => true

  def dialoger(user)
    dialoger = self.participants.select {|v| v != user}
    return dialoger[0]
  end

  def unread(recipient)
    self.messages.where(has_been_read: "unread", receiver: recipient)
  end
end