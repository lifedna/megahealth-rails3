# coding: utf-8
class TopicPresenter < BasePresenter
  include ActionView::Helpers
  include ApplicationHelper

  presents :topic

  def title
  	raw link_to(topic.title, show_community_topic_url(topic.community, topic))
  end

  def text
  	raw truncate(strip_tags(topic.body), length: 80, omission: '.....')
  end

  def metadata
  	raw "#{topic.user.name} &middot; #{time_ago_in_words(topic.created_at).capitalize}前" 
  end

  def stats
    out ||= []
    out << "浏览#{topic.impressionist_count(:filter=>:session_hash)}次"
    out << "#{topic.comments.size}条回复"
    out << "#{topic.likers_count}人关注"

    return raw out.join(" &middot; ")
  end
end  