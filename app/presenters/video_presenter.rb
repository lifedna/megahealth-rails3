# coding: utf-8
class VideoPresenter < BasePresenter
  include ActionView::Helpers
  include ApplicationHelper

  presents :video

  def title
  	raw link_to(video.title, show_community_video_url(video.community, video))
  end

  def text
  	raw truncate(strip_tags(video.body), length: 140, omission: '.....') if video.body.length > 0
  end

  def metadata
  	raw "#{video.community.name}社群 &middot; #{time_ago_in_words(video.created_at)}前"
  end

  def stats
  	out ||= []
  	out << "浏览#{video.impressionist_count(:filter=>:ip_address)}次"
  	out << "#{video.likers_count}人收藏"

  	return raw out.join(" &middot; ")
  end
end  