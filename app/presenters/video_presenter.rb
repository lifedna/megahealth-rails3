# coding: utf-8
class VideoPresenter < BasePresenter
  include ActionView::Helpers
  include ApplicationHelper

  presents :video

  def title
  	raw link_to(video.title, show_community_video_url(video.community, video))
  end

  def text
  	raw truncate(strip_tags(video.body), length: 30, omission: '.....') if video.body.length > 0
  end

  def metadata
  	raw "<span class ='icon icon-16 icon-group'></span>#{video.community.name} &middot; #{time_ago_in_words(video.created_at)}前"
  end

  def stats
  	out ||= []
  	out << "#{video.impressionist_count(:filter=>:session_hash)}次浏览"
    out << "#{video.likers_count}人喜欢"
    out << "#{video.comments_count}条评论"  	

  	return raw out.join(" &middot; ")
  end
end  