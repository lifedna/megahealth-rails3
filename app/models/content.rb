# coding: utf-8
require 'taggable'

class Content
  include Mongoid::Document	
  include Mongoid::Timestamps	
  include Mongoid::Commentable
  # include Mongoid::TaggableWithContext
  # include Mongoid::TaggableWithContext::AggregationStrategy::MapReduce
  # include Mongoid::TaggableWithContext::AggregationStrategy::RealTime
  include Mongoid::Likeable
  include Mongoid::Search
  include Mongoid::Taggable

  paginates_per 8
  
  field :title, type: String
  field :body, type: String
  field :category, type: String
  field :locked, type: Boolean, :default => false
  field :impressions_count, type: Integer, :default => 0

  embeds_many :model_tags

  # impressionist gem
  is_impressionable :column_name => :impressions_count, :unique => :session_hash, :counter_cache => true

  validates :title, :presence => true
  validates :category, :inclusion => {:in => %w(健康知识 就医指南 治疗交流 护理园地 用药常识), :message => "%{value} is not a valid category" }, :allow_nil => true

  search_in :title, :body

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:body].blank? }, :allow_destroy => true

  # accepts_nested_attributes_for :model_tags, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  belongs_to :user

  scope :newest, desc(:created_at)
  scope :most_liked, desc(:likers_count)
  scope :most_commented, desc(:comments_count)

  scope :with_tag, ->(phrase){where('model_tags.name' => phrase)}


  def presenter_klass
    klass = "#{self.class.to_s}Presenter"
    klass.constantize
  end

  def content_type
    case self.class.to_s
    when "Article"
      out = "文章"
    when "Blog"
      out = "日记"
    when "Topic"
      out = "话题"
    when "Question"
      out = "问题"
    when "Video"
      out = "视频"  
    when "Poll"
      out = "投票"  
    else
      out = "content"
    end  
    return out
  end
end  