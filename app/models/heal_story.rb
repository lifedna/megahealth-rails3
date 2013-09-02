# coding: utf-8
class HealStory
  include Mongoid::Document	
  include Mongoid::Timestamps
  include Mongoid::Commentable
  include Mongoid::Likeable
  include Mongoid::Search

  field :title, type: String
  field :body, type: String
  field :public, type: Boolean, :default => true
  field :anonymous, type: Boolean, :default => true

  belongs_to :user
  belongs_to :issue, counter_cache: true
end