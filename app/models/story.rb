# coding: utf-8
class Story
  include Mongoid::Document	
  include Mongoid::Timestamps
  include Mongoid::Commentable
  include Mongoid::Likeable
  include Mongoid::Search

  field :title, type: String
  field :body, type: String
  field :category, type: String
  field :public, type: Boolean, :default => true
  field :locked, type: Boolean, :default => false
  field :anonymous, type: Boolean, :default => false

  belongs_to :user
  belongs_to :issue, counter_cache: true
  
  default_scope desc(:created_at)

  paginates_per 6
end