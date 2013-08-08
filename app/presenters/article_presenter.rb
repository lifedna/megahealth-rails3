# coding: utf-8
class ArticlePresenter < BasePresenter
  include ActionView::Helpers
  include ApplicationHelper

  presents :article

  def title
  	raw link_to(article.title, show_community_article_url(article.community, article))
  end

  def text
  	raw truncate(strip_tags(article.body), length: 140, omission: '.....')
  end

  def image
  	if first_image_url(article.body)
  	  raw image_tag(first_image_url(article.body), size: "80x80") 
  	else
  	  return nil
  	end
  end

  def metadata
  	raw "#{article.community.name}社群 &middot; #{time_ago_in_words(article.created_at).capitalize}前"
  end

  def stats
  	out ||= []
  	out << "浏览#{article.impressionist_count(:filter=>:session_hash)}次"
    out << "#{article.comments.size}条回复"
  	out << "#{article.likers_count}人收藏"

  	return raw out.join(" &middot; ")
  end
end  