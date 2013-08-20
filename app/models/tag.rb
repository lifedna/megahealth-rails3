# encoding: UTF-8
class Tag
  include Mongoid::Document

  field :name, type: String
  field :taggings_count, type: Integer, default: 0
  validates :name, presence: true, length: { maximum: 10 }, uniqueness: true

  has_many :taggings

end