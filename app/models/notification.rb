require 'state_machine'

class Notification
  include Mongoid::Document
  include Mongoid::Timestamps::Created
 
  field :verb, type:String
  field :count, type:Integer, default:0

  # Relationships
  belongs_to :receiver, :class_name => 'User', :inverse_of => :notifications_received
  belongs_to :sender, :class_name => 'User', :inverse_of => :notifications_sent
  belongs_to :notifiable, :polymorphic => true
 
  scope :unread, where(has_been_read:"unread")

  #validations
  validates_presence_of :verb, :receiver, :notifiable
 
  #state machine has been read message?
  state_machine :has_been_read, :initial => :unread do
     event :read_message do
        transition :from => :unread, :to => :read
     end
     event :mark_unread do
        transition :from => :read, :to => :unread
     end
  end

  def notifiabled_obj
      notifiable_type.constantize.find(notifiable_id)
  end
end