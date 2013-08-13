# coding: utf-8
class QuestionPresenter < BasePresenter
  include ActionView::Helpers
  include ApplicationHelper

  presents :question

  def title
  	raw link_to(question.title, show_community_question_url(question.community, question))
  end

  def text
  	raw truncate(strip_tags(question.body), length: 80, omission: '.....')
  end

  def metadata
  	raw "<span class ='icon icon-16 icon-user'></span>#{question.user.name} &middot; #{time_ago_in_words(question.created_at)}前" 
  end

  def stats
    out ||= []
    out << "#{question.impressionist_count(:filter=>:session_hash)}次浏览"
    out << "#{question.comments.size}条回复"
    out << "#{question.likers_count}人关注"

    return raw out.join(" &middot; ")
  end
end  