class FeatureFilter
  include Mongoid::Document

  field :conditions, type: Hash
  field :symptoms, type: Hash
  field :treatments, type: Hash

  belongs_to :user

  def merged_keywords
  	keywords = conditions.merge(symptoms).merge(treatments).select {|k,v| v == "1"}
  	# keywords = conditions.merge(symptoms).merge(treatments)
  	keywords.keys.join(' ')
  end
end