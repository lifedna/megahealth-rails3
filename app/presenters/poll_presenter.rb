# coding: utf-8
class PollPresenter < BasePresenter
  include ActionView::Helpers
  include ApplicationHelper

  presents :poll

  def title
  	raw link_to(poll.title, show_community_poll_url(poll.community, poll))
  end

  def text
  	raw truncate(strip_tags(poll.body), length: 140, omission: '.....')
  end

  # def image
  # 	if first_image_url(article.body)
  # 	  raw image_tag(first_image_url(article.body), size: "80x80") 
  # 	else
  # 	  return nil
  # 	end
  # end

  def metadata
  	raw "<span class ='icon icon-16 icon-group'></span>#{poll.community.name}社群 &middot; #{time_ago_in_words(poll.created_at)}前"
  end

  def stats
  	out ||= []
  	out << "#{poll.impressionist_count(:filter=>:session_hash)}次浏览"
    out << "#{poll.comments.size}条回复"
  	out << "#{poll.likers_count}人关注"

  	return raw out.join(" &middot; ")
  end
end  