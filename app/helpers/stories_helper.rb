# coding: utf-8
module StoriesHelper
  def sort_by(string)
  	case string
  	when "newest"
  	  return "最新"
  	when "most_viewed"
  	  return "浏览"	
  	when "most_commented"
  	  return "评论"	
  	when "most_useful"
  	  return "有用"	
  	when "most_cheered"
  	  return "感谢"
  	else
  	  return "最新"	
  	end
  end	
end
