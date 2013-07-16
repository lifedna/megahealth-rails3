# coding: utf-8
class Phr
  include Mongoid::Document	
  include Mongoid::Timestamps

  field :name, type: String
  field :age, type: Integer
  field :gender, type: String
  field :relationship, type: String
  field :residence, type: String

  embeds_many :conditions
  embeds_many :symptoms
  embeds_many :treatments

  accepts_nested_attributes_for :conditions, reject_if: proc { |attributes| attributes["name"].blank? }
  accepts_nested_attributes_for :symptoms, reject_if: proc { |attributes| attributes["name"].blank? }
  accepts_nested_attributes_for :treatments, reject_if: proc { |attributes| attributes["name"].blank? }

  validates :gender, :inclusion => {:in => %w(男 女), :message => "%{value} is not a valid gender" }, :allow_nil => true	
  validates :relationship, :inclusion => {:in => %w(父亲 母亲 配偶 儿子 女儿 亲戚 朋友 自己), :message => "%{value} is not a valid relationship" }, :allow_nil => true	

  belongs_to :user
  # has_one :feature_filter

  class << self
    def conditions_keywords 
      Phr.distinct('conditions.name')
      # Phr.distinct('conditions.name').join(' ')
    end

    def symptoms_keywords
      Phr.distinct('symptoms.name')
      # Phr.distinct('symptoms.name').join(' ')
    end

    def treatments_keywords
      Phr.distinct('treatments.name')
      # Phr.distinct('treatments.name').join(' ')
    end  
  end 

  def conditions_keywords
    Phr.where(id: self.id).distinct('conditions.name')
    # Phr.where(id: self.id).distinct('conditions.name').join(' ')
  end

  def symptoms_keywords
    Phr.where(id: self.id).distinct('symptoms.name')
    # Phr.where(id: self.id).distinct('symptoms.name').join(' ')
  end
  
  def treatments_keywords
    Phr.where(id: self.id).distinct('treatments.name')
    # Phr.where(id: self.id).distinct('treatments.name').join(' ')
  end

   

  # Callbacks
  # after_create :create_initialize_filter

  # def create_initialize_filter
  #   self.build_feature_filter.tap do |i|
  #     i.filters = Hash.new
  #     i.phr = self
  #     i.save
  #   end
  # end
end