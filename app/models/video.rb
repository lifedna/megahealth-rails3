class Video
  include Mongoid::Document	
  include Mongoid::Timestamps
  include Getvideo

  field :title, type: String
  field :url, type: String
  field :provider, type: String

  validates :title, :url, :presence => true
  validates :url, :uniqueness => true

  def info
  	Getvideo.parse(self.url)
  end 	

  belongs_to :community
  belongs_to :video_list
end