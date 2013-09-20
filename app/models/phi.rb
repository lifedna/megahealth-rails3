# coding: utf-8
class Phi
  include Mongoid::Document	
  include Mongoid::Timestamps	

  field :name, type: String
  field :status, type: String
  field :started_at, type: Time
  field :ended_at, type: Time

  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :user
  belongs_to :issue
  has_many :stories
end  