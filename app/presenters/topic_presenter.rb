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
  	raw "<span class ='icon icon-16 icon-user'></span>#{topic.user.name} 提问 &middot; #{time_ago_in_words(topic.last_updated_at).capitalize}前更新" 
  end

  def stats
    out ||= []
    out << "#{topic.impressionist_count(:filter=>:session_hash)}次浏览"
    out << "#{topic.likers_count}人喜欢"
    out << "#{topic.comments_count}条回复"   

    return raw out.join(" &middot; ")
  end

end  