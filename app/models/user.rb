# coding: utf-8
require 'state_machine'
require 'tagger'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Commenter
  include Streama::Actor
  include Mongoid::Liker
  include Mongoid::Sharer
  include Mongoid::Tagger

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String


  field :avatar, type: String
  field :age, type: Integer
  field :resident, type: String
  field :zipcode, type: Integer
  field :gender, type: Boolean

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  field :name, :type => String
  validates_presence_of :name
  attr_accessible :name, :email, :avatar,:age, :resident, :zipcode, :gender, :current_password, :password, :password_confirmation, 
                  :remember_me, :created_at, :updated_at

  #state machine first visited?
  state_machine :first_visit, :initial => :true do
     event :logged do
        transition :from => :true, :to => :false
     end
  end                

  has_and_belongs_to_many :communities

  has_many :contents
  has_many :stories
  has_many :phis
  has_many :questions
  has_many :poll_answers
  has_many :topics
  has_one :content_filter

  # user messaging
  has_and_belongs_to_many :conversations, :class_name => "Conversation", :inverse_of => :participants
  has_many :messages_sent, :class_name => 'Message', :inverse_of => :sender
  has_many :messages_received, :class_name => 'Message', :inverse_of => :receiver

  # user notification
  has_many :notifications_sent, :class_name => 'Notification', :inverse_of => :sender
  has_many :notifications_received, :class_name => 'Notification', :inverse_of => :receiver


  mount_uploader :avatar, AvatarUploader

  # Callbacks
  after_create :create_initial_filter

  # features filter
  def conditions_keywords
    self.phrs.distinct('conditions.name')
  end

  def symptoms_keywords
    self.phrs.distinct('symptoms.name')
  end
  
  def treatments_keywords
    self.phrs.distinct('treatments.name')
  end


  def followers
    User.excludes(:id => self.id).all
  end

  # user messaging
  def send_message(receiver, message)
    conversation = Conversation.find_or_create_by(:participant_ids.all => [self.id, receiver.id])
    new_message = conversation.messages.build(sender: self, receiver: receiver)
    new_message.body = message
    new_message.save
  end
    
  private

  def create_initial_filter
    self.build_content_filter.tap do |f|
      f.phis = Hash.new
      f.user = self
      f.save
    end
  end    
end
