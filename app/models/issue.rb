# coding: utf-8
class Issue
  include Mongoid::Document	

  field :name, type: String
  field :pinyin, type: String
  field :stories_count, type: Integer, default: 0
  # field :heal_stories_count, type: Integer, default: 0

  validates :name, :uniqueness => true

  has_and_belongs_to_many :user
  has_many :stories

  before_create :set_pinyin

  scope :alphabet, ->(alpha) {where(pinyin: /^#{alpha.downcase}/)} 

  def healed_stories_count
    self.stories.where(category: '治愈').count
  end

  protected

  def set_pinyin
    self.pinyin = Pinyin.t(self.name.gsub(/\s+/, ""), splitter: '')
  end
end