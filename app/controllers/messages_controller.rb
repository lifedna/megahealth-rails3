class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def new
  	@message = Message.new
  	@receiver = User.find params[:receiver_id]
  end

  def create
    receiver = User.find params[:message][:receiver_id]
    message = params[:message][:body]
    if current_user.send_message(receiver, message)
      redirect_to "/mailbox"
    end
  end
end