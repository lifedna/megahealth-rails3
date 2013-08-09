class Widgets::PollsController < ApplicationController
  def index
    @polls = PollSet.find(params[:poll_set_id]).polls 
  end

  def new    
    @poll_set = PollSet.find(params[:poll_set_id])
    @poll = Poll.new
    4.times do 
      @poll.options.build
    end
  end

  def create
    @poll_set = PollSet.find(params[:poll_set_id])
    @poll = Poll.new(params[:poll])
    if @poll.save
      # current_user.publish_activity(:new_poll, :object => @poll, :target_object => @poll_set.community)
      redirect_to community_section_path(@poll_set.community, @poll_set.section) 
    else  
      render :action => "new"
    end
  end

  def show
    @poll = Poll.find params[:id]
    @community = Community.find params[:community_id]
    @current_section = @poll.poll_set.section
    @sections = @community.sections

    impressionist @poll, nil, :unique => [:session_hash]
  end

  def update
    @poll = Poll.find(params[:id])
    if @poll.update_attributes(params[:poll])
      # redirect_to @poll, :notice  => "Successfully updated survey."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy
    # redirect_to surveys_url, :notice => "Successfully destroyed survey."
  end

  def answer
    poll = Poll.find params[:poll][:id]
    if poll.multiple_allowed
      options = params['poll_answer']
      options.each do |key, value|
        create_poll_answer(poll, value) 
      end
    else  
      poll_option_id = params['poll_answer']['poll_option_id']
      create_poll_answer(poll, poll_option_id) 
    end
    redirect_to show_community_poll_path(poll.community, poll)
  end

  def details
    @poll = Poll.find params[:id]
    @community = Community.find params[:community_id]
    @current_section = @poll.poll_set.section
    @sections = @community.sections
  end

  private

  def create_poll_answer(poll, poll_option_id) 
    poll_option = poll.options.find_by(id: poll_option_id)
    poll_answer = PollAnswer.new

    if poll_answer.save
      poll_option.poll_answers << poll_answer
      current_user.poll_answers << poll_answer
    end
  end
end
