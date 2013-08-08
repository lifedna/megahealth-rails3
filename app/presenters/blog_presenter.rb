# coding: utf-8
class BlogPresenter < BasePresenter
  include ActionView::Helpers
  include ApplicationHelper

  presents :blog

  def title
  	raw link_to(blog.title, blog_url(blog))
  end

  def text
  	raw truncate(strip_tags(blog.body), length: 140, omission: '.....')
  end

  def image
  	if first_image_url(blog.body)
  	  raw image_tag(first_image_url(blog.body), size: "80x80") 
  	else
  	  return nil
  	end
  end

  def metadata
  	raw "<span class ='icon icon-16 icon-user'></span>#{blog.user.name} &middot; #{time_ago_in_words(blog.created_at).capitalize}前" 
  end

  def stats
    out ||= []
    out << "#{blog.impressionist_count(:filter=>:session_hash)}次浏览"
    out << "#{blog.comments.size}条回复"
    out << "#{blog.likers_count}人喜欢"

    return raw out.join(" &middot; ")
  end
end  