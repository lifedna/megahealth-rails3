class Video < Content
  include Getvideo

  field :body, type: String
  field :url, type: String
  field :thumb, type: String
  field :src, type: String

  validates :title, :url, :presence => true
  validates :url, :uniqueness => true

  after_validation do |record|
    record.remote_thumb_url = Getvideo.parse(url).cover
    record.src = Getvideo.parse(url).flash
  end

  mount_uploader :thumb, VideoThumbUploader  

  belongs_to :community
  belongs_to :video_list

  # def info
  # 	Getvideo.parse(url)
  # end 	
end