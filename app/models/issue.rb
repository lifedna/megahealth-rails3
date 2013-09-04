# coding: utf-8
class Issue
  include Mongoid::Document	

  field :name, type: String
  field :pinyin, type: String
  field :notes_count, type: Integer, default: 0
  field :heal_notes_count, type: Integer, default: 0

  has_and_belongs_to_many :user
  has_many :stories

  before_create :set_pinyin

  scope :alphabet, ->(alpha) {where(pinyin: /^#{alpha}/)} 

  protected

  def set_pinyin
    self.pinyin = Pinyin.t(self.name, splitter: '').capitalize
  end
end