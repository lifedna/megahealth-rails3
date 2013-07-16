class Symptom
  include Mongoid::Document	

  field :name, type: String
  field :extent, type: String
  field :started_at, type: Time
  field :ended_at, type: Time  

  embedded_in :phr
end