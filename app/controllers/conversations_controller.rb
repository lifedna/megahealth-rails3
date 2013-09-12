# encoding: UTF-8
class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def show
  	@c = Conversation.find params[:id]
  	@dialoger = @c.dialoger(current_user)
  	@messages = @c.messages
    @message = Message.new
  	unreads = @c.unread(current_user)
  	unreads.each do |m|
  	  m.read_message	
      m.save
  	end
  end

  def reply
    receiver = User.find params[:receiver_id]
    message = params[:body]
    if current_user.send_message(receiver, message)
      redirect_to :action => "show"
    else
      flash[:notice] = "邮件字数不得小于10"
      redirect_to :action => "show"
    end    
  end
end