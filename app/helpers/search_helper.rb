# coding: utf-8
module SearchHelper
  def scope_by(string)
    case string
    when "most_liked"
      return "最多喜欢" 
    when "most_commented"
      return "最多评论" 
    else
      return "最新" 
    end
  end

  def breadcrumb(*args)
  	options = args.extract_options!
  	out = []

  	if options[:tag]
	  out << link_to(options[:tag], search_path(:tag => options[:tag]))
	  out << link_to(options[:category], search_path(:tag => options[:tag], :category => options[:category])) if options[:category]
	  out << link_to(translate(options[:type]), search_path(:tag => options[:tag], :category => options[:category], :type => options[:type])) if options[:type]
	end

	if options[:q]
	  out << link_to(options[:q], search_path(:q => options[:q]))
	  out << link_to(options[:category], search_path(:q => options[:q], :category => options[:category])) if options[:category]
	  out << link_to(translate(options[:type]), search_path(:q => options[:q], :category => options[:category], :type => options[:type])) if options[:type]
	end

	return raw out.join(" > ")
  end

  private

  def translate(type)
  	case type
  	when "Article"
  	  return "文章"
  	when "Blog"
  	  return "日记"
  	when "Video"
  	  return "视频"
  	when "Topic"
  	  return "话题"
  	when "Question"
  	  return "问题"    
  	when "Poll"
  	  return "投票" 
  	else
  	  return     
  	end
  end
end