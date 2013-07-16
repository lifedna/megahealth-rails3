# coding: utf-8
class Blog
  include Mongoid::Document	
  include Mongoid::Timestamps
  include Mongoid::Commentable
  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::MapReduce
  include Mongoid::Likeable
  include Mongoid::Search
  
  taggable

  field :title, type: String
  field :body, type: String
  field :hits, type: Integer, :default => 0
  field :locked, type: Boolean, :default => false
  field :public, type: Boolean, :default => true
  field :category, type: String

  search_in :title, :body


  validates :title, :body, :presence => true
  validates :category, :inclusion => {:in => %w(健康知识 就医指南 治疗交流 护理园地 用药常识), :message => "%{value} is not a valid category" }, :allow_nil => true

  belongs_to :user

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:body].blank? }, :allow_destroy => true

  def hit!
    self.class.increment_counter :hits, id
  end  	

  def liked?(user)
    return self.likers.include?(user)
  end
end