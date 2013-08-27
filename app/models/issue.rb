# coding: utf-8
class Issue
  include Mongoid::Document	
  include Mongoid::Timestamps

  field :name, type: String
  field :symptoms, type: String
  field :body, type: String
  field :status, type: String
  field :started_at, type: Time
  field :ended_at, type: Time 
  field :assignee, type: String

  validates :assignee, :inclusion => {:in => %w(自己 父亲 母亲 配偶 儿子 女儿 姊妹 兄弟 亲戚), :message => "%{value} is not a valid assignee" }, :allow_nil => true	

  belongs_to :user
end