# coding: utf-8
class CommunityPresenter < BasePresenter
  include ActionView::Helpers
  include ApplicationHelper

  presents :community

  def title
  	raw link_to(article.title, show_community_article_url(article.community, article))
  end

  def text
  	raw truncate(strip_tags(article.body), length: 140, omission: '.....')
  end


  def metadata
    out = []
    out << community.organization
    out << community.dept
    out << community.title
  	return raw out.join(" &nbsp; ")
  end

end