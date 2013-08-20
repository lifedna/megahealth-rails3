# encoding: UTF-8
class ModelTag
  include Mongoid::Document

  field :name, type: String
  field :taggings_count, type: Integer, default: 0
  field :user_ids, type: Array, default: []

  validates :name, presence: true, length: { maximum: 10 }
  # validates_uniqueness_of :name, :scope => :content_id

  belongs_to :content

  def tagged_by_user(user_id)
  	return self.user_ids.include?(user_id)
  end
end