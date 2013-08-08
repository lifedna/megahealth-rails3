# coding: utf-8
class Content
  include Mongoid::Document	
  include Mongoid::Timestamps	
  include Mongoid::Commentable
  include Mongoid::TaggableWithContext
  # include Mongoid::TaggableWithContext::AggregationStrategy::MapReduce
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime
  include Mongoid::Likeable
  include Mongoid::Sharable
  include Mongoid::Search

  paginates_per 5

  taggable
  # impressionist gem
  is_impressionable :counter_cache => true
  
  field :title, type: String
  field :body, type: String
  field :category, type: String
  field :locked, type: Boolean, :default => false

  validates :title, :presence => true
  validates :category, :inclusion => {:in => %w(健康知识 就医指南 治疗交流 护理园地 用药常识), :message => "%{value} is not a valid category" }, :allow_nil => true

  search_in :title, :body

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:body].blank? }, :allow_destroy => true

  belongs_to :user

  # default_scope desc(:created_at)
  scope :newest, desc(:created_at)
  scope :hot, desc(:likers_count)
  scope :popular, desc(:impressionist_count)
end  