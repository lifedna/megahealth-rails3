class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def show
  	c = Conversation.find params[:id]
  	@dialoger = c.dialoger(current_user)
  	@messages = c.messages
  	unreads = c.unread(current_user)
  	unreads.each do |m|
  	  m.read_message	
  	end
  end
end