# encoding: UTF-8
class Tagging
  include Mongoid::Document

  belongs_to :tagger, :class_name => "User", :inverse_of => :taggings
  belongs_to :taggable, :polymorphic => true
  belongs_to :tag

  validates :tagger, presence: true
  validates :taggable, presence: true
  validates :tag, presence: true

  def tagging_obj
    Tag.find(tag_id)
  end

  def tagged_obj
    taggable_type.constantize.find(taggable_id)
  end

  def tagger
    User.find(tagger_id)
  end
end