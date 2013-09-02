# coding: utf-8
class Phi
  include Mongoid::Document	
  include Mongoid::Timestamps	

  field :name, type: String
  field :status, type: String
  field :started_at, type: Time
  field :ended_at, type: Time

end  