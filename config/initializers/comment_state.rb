require 'state_machine'

module Mongoid
  class Comment
    field :receivers, type: Array, default: Array.new
    scope :unread, where(has_been_read:"unread")

    #state machine has been read message?
    state_machine :has_been_read, :initial => :unread do
       event :read_message do
          transition :from => :unread, :to => :read
       end
       event :mark_unread do
          transition :from => :read, :to => :unread
       end
    end
  end
end