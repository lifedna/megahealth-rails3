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
  	raw "#{blog.user.name} &middot; #{time_ago_in_words(blog.created_at).capitalize}前" 
  end

  def stats
    out ||= []
    out << "浏览#{blog.impressionist_count(:filter=>:ip_address)}次"
    out << "#{blog.likers_count}人喜欢"

    return raw out.join(" &middot; ")
  end
end  