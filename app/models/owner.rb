class Owner
  include Mongoid::Document
  embedded_in :community	
end