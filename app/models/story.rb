# coding: utf-8
require 'taggable'

class Story
  include Mongoid::Document	
  include Mongoid::Timestamps
  include Mongoid::Commentable
  include Mongoid::Likeable
  include Mongoid::Sharable
  include Mongoid::Search
  include Mongoid::Taggable

  field :title, type: String
  field :body, type: String
  field :category, type: String
  field :public, type: Boolean, :default => true
  field :locked, type: Boolean, :default => false
  field :anonymous, type: Boolean, :default => false
  field :impressions_count, type: Integer, :default => 0

  # embeds_many :model_tags

  belongs_to :user
  belongs_to :issue, counter_cache: true
  belongs_to :issue, :inverse_of => :heal_stories, counter_cache: true

  scope :newest, desc(:created_at) 
  scope :most_viewed, desc(:impressions_count)
  scope :most_commented, desc(:comments_count)
  scope :most_useful, desc(:likers_count)
  scope :most_cheered, desc(:shares_count)

  paginates_per 6

  # impressionist gem
  is_impressionable :column_name => :impressions_count, :unique => :session_hash, :counter_cache => true
end