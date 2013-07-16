class Treatment
  include Mongoid::Document	

  field :name, type: String
  field :dose, type: String
  field :started_at, type: Time
  field :ended_at, type: Time
  field :effect, type: String  

  embedded_in :phr
end