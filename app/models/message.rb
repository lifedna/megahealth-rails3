require 'state_machine'

class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created
 
  # field :subject, type:String
  field :body, type:String

  # Relationships
  belongs_to :sender, :class_name => 'User', :inverse_of => :messages_sent
  belongs_to :receiver, :class_name => 'User', :inverse_of => :messages_received
  belongs_to :conversation
  # belongs_to :thread, :class_name => 'Message'  # Reference to parent message
  # has_many :replies,  :class_name => 'Message', :foreign_key => 'thread_id'
  # scope :in_reply_to, lambda { |message| where({:thread => message}).asc('created_at') }
 
  #validations
  validates_presence_of :body, :sender, :receiver
  # validates_length_of :subject, :within => 10..70
  validates_length_of :body, :within => 10..1000
 
  #state machine has been read message?
  state_machine :has_been_read, :initial => :unread do
     event :read_message do
        transition :from => :unread, :to => :read
     end
     event :mark_unread do
        transition :from => :read, :to => :unread
     end
  end
 
  #state machine place_sender can be sent, draft, trash
   state_machine :place_sender, :initial => :draft do
     event :send_message do
       transition :from => :draft, :to => :sent
     end
     event :sender_send_to_trash do
       transition :from => :draft, :to => :drafts_trash
     end
    end
 
   #state machine place_sender can be inbox, trash, spam
    state_machine :place_receiver, :initial => :in_box do
     event :receiver_send_to_trash do
      transition :from => :inbox, :to => :trash
     end
     event :receiver_send_to_spam do
      transition :from => :inbox, :to => :spam
     end
    end
end