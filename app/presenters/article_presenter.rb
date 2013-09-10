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
    out = []
    # out << "<span class ='icon icon-16 icon-group'></span>#{link_to article.community.name, community_path(article.community)}"
    out << "<span class ='icon icon-16 icon-group'></span>#{article.community.name}"
    out << "#{time_ago_in_words(article.created_at).capitalize}前"
  	return raw out.join(" &middot; ")
  end

  def stats
  	out ||= []
  	out << "#{article.impressionist_count(:filter=>:session_hash)}次浏览"
    out << "#{article.likers_count}人喜欢"
    out << "#{article.comments_count}条评论"
  	

  	return raw out.join(" &middot; ")
  end
end  